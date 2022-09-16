# Spring aws

- para criação da infra na aws, utilizaremos o cdk
- este permite criar recursos na aws via uma linguagem de programação
- para criar uma app cdk, precisa do node instalado previamente.
- aws cli com usuario e senha configurados
- precisamos de uma stack base:
````
cdk bootstrap aws://ACCOUNT_NUMBER/REGION
````
- comando para criar:
````
cdk init app --language=java
````
- na aplição temos uma classe main (principal) e uma classe com sufix stack, aonde podemos criar uma pode recurso
- por tráz o cdk gera arquivos cloudformation e os aplica na aws
- para implantar:
````
cdk deploy -c accountId=ACCOUNT_NUMBER -c region=REGION
````
- para destruir:
````
cdk destroy -c accountId=ACCOUNT_NUMBER -c region=REGION
````
- na nossa aplicação podemos colocar o nome do construtor, aonde aparecerá na stack na aws

