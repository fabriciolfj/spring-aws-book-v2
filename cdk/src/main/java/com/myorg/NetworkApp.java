package com.myorg;

import dev.stratospheric.cdk.Network;
import software.amazon.awscdk.App;
import software.amazon.awscdk.Environment;
import software.amazon.awscdk.Stack;
import software.amazon.awscdk.StackProps;

import static com.myorg.Validations.requireNonEmpty;

public class NetworkApp {

    public static void main(String[] args) {
        App app = new App();

        String environmentName = (String) app.getNode()
                .tryGetContext("environmentName");

        requireNonEmpty(environmentName, "environmentName");

        String accountId = (String) app.getNode()
                .tryGetContext("accountId");

        requireNonEmpty(accountId, "accountId");

        String region = (String) app.getNode()
                .tryGetContext("region");

        requireNonEmpty(region, "region");

        Environment environmentAws = makeEnv(accountId, region);

        Stack networkStack = new Stack(
                app,
                "NetworkStack",
                StackProps.builder()
                        .stackName(environmentName + "-Network")
                        .env(environmentAws)
                        .build());

        Network network = new Network(
                networkStack,
                "Network",
                environmentAws,
                environmentName,
                new Network.NetworkInputParameters()
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
