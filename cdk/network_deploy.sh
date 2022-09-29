cdk deploy --app "./mvnw -e -q compile exec:java -Dexec.mainClass=com.myorg.NetworkApp" --require-approval never \
                                                                                                                  -c accountId=849316406353 \
                                                                                                                  -c region=sa-east-1 \
                                                                                                                  -c applicationName=spring