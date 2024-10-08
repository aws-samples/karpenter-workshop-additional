
accid=$(aws sts get-caller-identity --query Account --output text)
echo "Account ID: ${accid}"
echo "Revoke IAM_ALLOWED_PRINCIPALS"
aws lakeformation revoke-permissions --principal DataLakePrincipalIdentifier=IAM_ALLOWED_PRINCIPALS --resource '{ "Catalog": {}}' --permissions CREATE_DATABASE
#
echo "Grant GlueExecutionRole"
cat <<EOF >input1.json
{
    "CatalogId": "${accid}",
    "Principal": {
        "DataLakePrincipalIdentifier": "arn:aws:iam::${accid}:role/GlueExecutionRole"
    },
    "Resource": {
        "Database": {
            "CatalogId": "${accid}",
            "Name": "raw"
        }
     },
    "Permissions": ["CREATE_TABLE"],
    "PermissionsWithGrantOption": []
}
EOF
cat <<EOF >input2.json
{
    "CatalogId": "${accid}",
    "Principal": {
        "DataLakePrincipalIdentifier": "arn:aws:iam::${accid}:role/GlueExecutionRole"
    },
    "Resource": {
        "Database": {
            "CatalogId": "${accid}",
            "Name": "analytics"
        }
     },
    "Permissions": ["CREATE_TABLE"],
    "PermissionsWithGrantOption": []
}
EOF
cat <<EOF >input3.json
{
    "CatalogId": "${accid}",
    "Principal": {
        "DataLakePrincipalIdentifier": "arn:aws:iam::${accid}:role/GlueExecutionRole"
    },
    "Resource": {
        "Database": {
            "CatalogId": "${accid}",
            "Name": "stage"
        }
     },
    "Permissions": ["CREATE_TABLE"],
    "PermissionsWithGrantOption": []
}
EOF
echo "aws lakeformation grant-permissions 1"
aws lakeformation grant-permissions --cli-input-json file://input1.json
echo "aws lakeformation grant-permissions 2"
aws lakeformation grant-permissions --cli-input-json file://input2.json
echo "aws lakeformation grant-permissions 3"
aws lakeformation grant-permissions --cli-input-json file://input3.json

cat <<EOF >input4.json
{
    "CatalogId": "${accid}",
    "Principal": {
        "DataLakePrincipalIdentifier": "arn:aws:iam::${accid}:role/GlueExecutionRole"
    },
    "Resource": {
        "Table": {
            "CatalogId": "${accid}",
            "DatabaseName": "raw",
            "TableWildcard": {}
            }
     },
    "Permissions": ["SELECT","ALTER"],
    "PermissionsWithGrantOption": []
}
EOF
aws lakeformation grant-permissions --cli-input-json file://input4.json

