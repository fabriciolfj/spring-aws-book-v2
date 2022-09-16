cdk bootstrap aws://ACCOUNT_NUMBER/REGION

#para implantar/ caso tenha parametros informe
cdk deploy -c accountId=ACCOUNT_NUMBER -c region=REGION

#para destruir
cdk destroy -c accountId=ACCOUNT_NUMBER -c region=REGION

