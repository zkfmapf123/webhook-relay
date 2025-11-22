# AWS Webhook Relay

## CheckList

- [x] init terraform resources (lb, lambda, secret manager)
- [ ] add to api
  - [ ] add to webhook api
  - [ ] listing webhook apis
  - [ ] delete webhook api
  - [ ] communication webhook relay

## Resource

- AWS IAM Role (Github OIDC) - Lambda 배포 용
- AWS Load Balancer
- AWS Lambda
- AWS Secret Manager (Webhook URL 저장)

## 구성에 필요한 부분

- OIDC IAM Role 만들기
- Github Action 사용하기 위해선 아래 키 값들을 정의 해야 합니다
  - AWS_OIDC_ARN
  - LAMBDA_FUNCTION_NAME
