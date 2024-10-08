
A

CT - create trail
mda-events - new S3 , kms enabled, New key, "mda-key-alias", log file validation enabled, 
CW logs enabled, New, IAM role, new "mda-cw-role"  next

Management events, data events - Read Write - exclude KMS & RDS
Data event - Lake Formation - next - create trail


CT Event History - Create Athena Table "cloudtrail_logs_aws_cloudtrail_logs_007532665219_5cf285c3"

B Revoke IAMAllowed Create database
Grant GlueExecution Role





Stream 1

aws ssm get-parameters --name DMSExecutionRoleArn RawBucketName --query 'Parameters[].[Name,Value]'
DMS endpoints - "mdadb" source RDS DB(Aurora PosrGres) - mdadb u: mdauser pw: Admin123$

target endpoint - "target-s3" , role DMSExecutionRole, bucker folder reviews 
enspoont connectionattibtes


DMS migration task - cdc-task  (replicate data changes only)
repliaction instance "aurora-s3-repinstance-**"
source mdadb
target target-s3
replate data changes only

B.
Lambda - write changes to db

run crawler - raw_data-crawler  ( see new table - "raw_reviews")



## Stream 2

LF Column

LF Row

LF Tag

LF Audit Trails



## Stream 3

Redshift
aws ssm get-parameters --name RedshiftExecutionRoleArn StageBucketName AnalyticsBucketName AuroraEndpoint AuroraSecretARN --query 'Parameters[].[Name,Value]'

Login query editor 2:





Fed Query Athena

Apache Spark and Athena


## Stream 4

Data Profile Glue DataBrew

Sentiment Analysis Sagemaker

Feature Engineering wirth SageMaker Data Wrangler

Dashboard with Quicksight

Log Analytics OpenSearch

Full Text Search with OpenSearch

## Stream 5

### Discover and Share with Data Zone
Create Domain - "MDADomain" - default options
Blueprint - DefaultDataWarehouse - Enable
Open Data portal
Create Project - "SalesDataProducts" (MDADomain selected) -  Create   (x to close)
Create Profile - "ProvisionedClusterEnvProfile" select DefaultDataWareHouse blueprint
Parameter set - enter my own - set account & region
Parameters - Redshift Cluster

separate tab:
secrets manager - stora new secret - cred for Redshift data warehouse - user:admin pw: Admin123$
Data Warehouse:   mdawarehouse-5vskqrcj999g   (not the serverless one_)
Next
Secret name: "Redshift/provisioned"
Tags
`aws datazone list-domains --query 'items[].id' --output text`
Name : AmazonDataZoneDomain Value: dzd-*********   
`aws datazone list-projects --domain-identifier $(aws datazone list-domains --query 'items[].id' --output text) --query 'items[].id' --output text`
Name: AmazonDataZoneProject Value: SalesDataProducts
Name: datazone.rs.cluster   Value: mdawarehouse-5vskqrcj999g:dev    (-note: format is <clustername>:<database>)

Next, Next, Store

Back in DataZone
enter secret arn
cluster name: mdawarehouse-5vskqrcj999g
Database name: Dev

Authorized projects only - SalesDatProducts
Publish from anny schema
Create Environment Profile

-------

(in environment profiles)
Click - Create Environment from profile 
Name "ProvisionedClusterEnvProfile"
Custom Schema Name: "dataproducts"
Click "Create Environment"

....  takes  a few minues .......


Data tab - Data Sources  3x vertical dots - actions - edit datascource - scroll to bottom
add another databas e- schema public - next, next, save

Data source runs tab - run in (top rhs) 

shoud see sales and daily_sales_revenue     (**created in stream3 - redshift part)


![alt text](image.png)
AmazonDataZoneDomain = dzd_4hdpc6s6xgpwye
AmazonDataZoneProject = 5ztw4o6y9q32qe


### Cross Account Sharing with Lake Formation

