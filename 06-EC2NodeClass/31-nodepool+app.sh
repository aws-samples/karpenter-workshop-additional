cd ~/environment/karpenter  || mkdir -p ~/environment/karpenter  && cd ~/environment/karpenter 
cat > basic-deploy-blockdevice.yaml <<EOF
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  disruption:
    consolidateAfter: 30s
    consolidationPolicy: WhenEmpty
    expireAfter: Never
  limits:
    cpu: "10"
  template:
    metadata:
        labels:
         eks-immersion-team: my-team
    spec:
      nodeClassRef:
        name: default
      requirements:
      - key: karpenter.k8s.aws/instance-category
        operator: In
        values: ["c", "m", "r"]
      - key: kubernetes.io/arch
        operator: In
        values: ["amd64"]
      - key: karpenter.sh/capacity-type # If not included, the webhook for the AWS cloud provider will default to on-demand
        operator: In
        values: ["on-demand"]
      - key: kubernetes.io/os
        operator: In
        values: ["linux"]


---
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiFamily: AL2
  role: karpenterNodeRole-$CLUSTER_NAME
  securityGroupSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  subnetSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  blockDeviceMappings:
    - deviceName: /dev/xvda # root Volume to store OS Binaries
      ebs:
        volumeType: gp3 # EBS Volume Type
        volumeSize: 20Gi # Size of the disk
        deleteOnTermination: true # Disk Retention Policy
    - deviceName: /dev/xvdb # Data Volume to store Images, Logs etc
      ebs:
        volumeType: gp3 # EBS Volume Type
        volumeSize: 100Gi # Size of the disk
        deleteOnTermination: true # Disk Retention Policy
  userData: |
    #!/bin/bash

    # Mount data volumes to /data$N directory on a Amazon Linux Worker Node (excluding OS volume)
    
    # Identify the device name of the root volume
    root_device=\$(mount | awk '\$3 == "/" {print \$1}')
    
    # Identify the device names of all attached block devices (excluding root volume)
    device_names=\$(lsblk -d -n -o NAME | grep -v "\$root_device")
    
    # Loop through each device name and mount the corresponding volume to a directory named /data$N
    i=1
    for device_name in \$device_names; do
      if ! grep -qs "/dev/\$device_name" /proc/mounts; then
        sudo mkfs.xfs "/dev/\$device_name"
        sudo mkdir -p "/data\${i}"
        sudo mount "/dev/\$device_name" "/data\${i}"
        echo "Mounted /dev/\$device_name to /data\${i}"

        ((i++))
      fi
    done
  
  tags:
    intent: apps
    managed-by: karpenter

EOF

kubectl apply -f basic-deploy-blockdevice.yaml

cd ~/environment/karpenter  || mkdir -p ~/environment/karpenter  && cd ~/environment/karpenter 
cat > basic-app-deploy.yaml <<'EOF' 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 1
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      terminationGracePeriodSeconds: 0
      containers:
        - name: inflate
          image: nginx
          volumeMounts:
          - name: my-app-volume
            mountPath: /var/log/nginx
          resources:
            requests:
              cpu: 1
      volumes:
      - name: my-app-volume
        hostPath:
          path: /data1
      nodeSelector:
        eks-immersion-team: my-team
EOF

kubectl apply -f basic-app-deploy.yaml

echo "ssm onto node - checkout /data1 - tail log file"

