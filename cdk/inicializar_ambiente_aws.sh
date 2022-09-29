cdk bootstrap aws://ACCOUNT_NUMBER/REGION

#para implantar/ caso tenha parametros informe
cdk deploy -c accountId=849316406353 -c region=sa-east-1

#para destruir
cdk destroy -c accountId=ACCOUNT_NUMBER -c region=REGION

