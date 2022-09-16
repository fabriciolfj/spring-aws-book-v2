package com.myorg;

import dev.stratospheric.cdk.SpringBootApplicationStack;
import software.amazon.awscdk.App;
import software.amazon.awscdk.Environment;
import software.amazon.awscdk.StackProps;

import java.util.Arrays;

public class CdkApp {
    public static void main(final String[] args) {
        App app = new App();

        String accountId = (String) app.getNode().tryGetContext("accountId");

        String region = (String) app.getNode().tryGetContext("region");

        new SpringBootApplicationStack(
                app, "SpringBootApplication", makeEnv(accountId, region),
                "docker.io/fabricio211/spring-aws:latest"
        );
        app.synth();
    }

    static Environment makeEnv(String account, String region) {
        return Environment.builder()
                .account(account)
                .region(region)
                .build();
    }
}

