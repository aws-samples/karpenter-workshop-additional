aws lakeformation get-data-lake-settings --query DataLakeSettings.DataLakeAdmins --output text | cut -f2- -d'/' | grep WSParticipantRole > /dev/null
if [[ $? -eq 0 ]]; then
    echo "PASSED: Found WSParticipantRole role as LF admin"
else
    echo "ERROR: did not find WSParticipantRole role as LF admin"
fi
lv=$(aws lakeformation get-data-lake-settings --query DataLakeSettings.Parameters --output text) 
if [[ $lv == "3"* ]]; then
    echo "PASSED: LF verison is 3 found version = $lv"
else
    echo "ERROR: LF verison is not 3 found version = $lv"
fi
lg=$(aws lakeformation list-permissions --output text | grep GlueExecutionRole | wc -l)
if [[ $lg -lt 1 ]]; then
    echo "ERROR: did not find GlueExecutionRole role in LF permissions"
else
    echo "PASSED: Found GlueExecutionRole role in LF permissions"
fi
ip=$(aws lakeformation list-permissions --output text | grep IAMAllowedPrincipals | wc -l)
if [[ $ip -eq 0 ]]; then
    echo "PASSED: IAMAllowedPrincipals not in LF permissions"

else
    echo "ERROR: IAMAllowedPrincipals found in LF permissions - not expected"
fi
echo "check cloudtrail exists"
aws cloudtrail list-trails --query "Trails[].Name" | grep mda-events | jq -r .
echo "4x raw tables exist"
aws glue get-tables --database-name raw --query "TableList[].Name" | jq -r '.[]'
echo "2x stage tables exist"
aws glue get-tables --database-name stage --query "TableList[].Name" | jq -r '.[]'