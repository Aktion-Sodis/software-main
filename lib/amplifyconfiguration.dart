const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "monitoring": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://s7pvubsl6ffpbfjmz6xn2yx46a.appsync-api.eu-central-1.amazonaws.com/graphql",
                    "region": "eu-central-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-m4hdqi3h5baa5hwrwpdqgnl5j4"
                },
                "AdminQueries": {
                    "endpointType": "REST",
                    "endpoint": "https://o5yxww9rn3.execute-api.eu-central-1.amazonaws.com/dev",
                    "region": "eu-central-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://s7pvubsl6ffpbfjmz6xn2yx46a.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-m4hdqi3h5baa5hwrwpdqgnl5j4",
                        "ClientDatabasePrefix": "monitoring_API_KEY"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-central-1:df4c579c-5cd5-4d01-858a-92e9c83742b7",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_xXF4NoKsm",
                        "AppClientId": "7jt688an8t62hq2k5c75hbm44t",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL",
                            "PHONE_NUMBER"
                        ],
                        "signupAttributes": [],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": "6",
                            "passwordPolicyCharacters": [
                                "REQUIRES_LOWERCASE",
                                "REQUIRES_UPPERCASE",
                                "REQUIRES_NUMBERS"
                            ]
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "PHONE_NUMBER"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "monitoring458d35c4cce0449db22ae25ed77dd515182045-dev",
                        "Region": "eu-central-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "monitoring458d35c4cce0449db22ae25ed77dd515182045-dev",
                "region": "eu-central-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';