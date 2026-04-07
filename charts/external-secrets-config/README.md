# External Secrets Config Chart

This Helm chart configures External Secrets Operator (ESO) integration with AWS Secrets Manager for the Expense Tracker project.

## Components

### ClusterSecretStore

Creates a cluster-wide SecretStore that allows any namespace to pull secrets from AWS Secrets Manager using IRSA.

### ArgoCD Repository Credentials

Creates an ExternalSecret that provisions ArgoCD repository credentials from AWS Secrets Manager. This enables ArgoCD to authenticate with private GitHub repositories using a GitHub App.

## Prerequisites

1. **External Secrets Operator** must be installed
2. **IRSA** must be configured with the following IAM policy attached to the ESO service account:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource": "arn:aws:secretsmanager:us-east-1:*:secret:argocd/*"
    }
  ]
}
```

## Values

| Key | Description | Default |
|-----|-------------|---------|
| `aws.region` | AWS region for Secrets Manager | `us-east-1` |
| `serviceAccount.name` | ESO service account name | `external-secrets` |
| `serviceAccount.namespace` | ESO service account namespace | `external-secrets` |
| `clusterSecretStore.name` | Name of the ClusterSecretStore | `aws-secrets-manager` |
| `argocd.enabled` | Enable ArgoCD repo credentials | `true` |
| `argocd.github.url` | GitHub URL pattern | `https://github.com/roeebronfeld` |
| `argocd.github.appID` | GitHub App ID | `2808083` |
| `argocd.github.installationID` | GitHub App Installation ID | `<set-me>` |
| `argocd.secretName` | AWS Secrets Manager secret name | `argocd/github-app-private-key` |
| `argocd.refreshInterval` | How often to sync | `1h` |

## Installation

This chart is deployed as part of the ArgoCD app-of-apps pattern. See the main GitOps documentation for details.

For manual installation:
```bash
helm install external-secrets-config ./external-secrets-config \
  --namespace external-secrets \
  --set argocd.github.installationID=<your-installation-id>
```
