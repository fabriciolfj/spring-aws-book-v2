cdk deploy \
 --app "./mvnw -e -q compile exec:java \
  -Dexec.mainClass=com.myorg.DockerRespositoryApp" \
 -c accountId=... \
 -c region=sa-east-1 \
 -c applicationName=spring