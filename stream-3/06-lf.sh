accid=$(aws sts get-caller-identity --query Account --output text)
cat <<EOF >input5.json
{
    "CatalogId": "${accid}",
    "Principal": {
        "DataLakePrincipalIdentifier": "arn:aws:iam::${accid}:role/RedshiftExecutionRole"
    },
    "Resource": {
        "Table": {
            "CatalogId": "${accid}",
            "DatabaseName": "stage",
            "Name": "stage_sales"
            }
     },
    "Permissions": ["SELECT"],
    "PermissionsWithGrantOption": []
}
EOF
aws lakeformation grant-permissions --cli-input-json file://input5.json