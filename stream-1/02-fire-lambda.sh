command=$(cat <<EOF
aws lambda invoke \
--payload '{"product_id":"88236","comment":"What an amazing product!","rating":"5", "name":"Your name"}' \
--function-name GenerateCDCRecord --invocation-type Event \
--cli-binary-format raw-in-base64-out \
/dev/stdout
EOF)
echo $command
eval $command
echo "sleep 90s and rerun crawler raw-data-crawler"
sleep 90
aws glue start-crawler --name raw-data-crawler
