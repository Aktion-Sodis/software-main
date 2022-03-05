export type AmplifyDependentResourcesAttributes = {
    "api": {
        "monitoring": {
            "GraphQLAPIKeyOutput": "string",
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        },
        "AdminQueries": {
            "RootUrl": "string",
            "ApiName": "string",
            "ApiId": "string"
        }
    },
    "auth": {
        "userPoolGroups": {
            "adminGroupRole": "string",
            "appusersGroupRole": "string",
            "statisticusersGroupRole": "string"
        },
        "sodisusers": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string",
            "CreatedSNSRole": "string"
        }
    },
    "function": {
        "AdminQueries3df1db39": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    },
    "storage": {
        "s3e48a1903": {
            "BucketName": "string",
            "Region": "string"
        }
    }
}