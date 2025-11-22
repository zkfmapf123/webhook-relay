# AWS Webhook Relay

Webhook을 중계하는 AWS 기반 서버리스 애플리케이션

## 📋 CheckList

- [x] Terraform 리소스 초기화 (ALB, Lambda, Secret Manager)
- [ ] API 구현
  - [ ] Webhook 추가 API
  - [ ] Webhook 목록 조회 API
  - [ ] Webhook 삭제 API
  - [ ] Webhook 중계 통신

## 🏗️ AWS Resources

- **AWS IAM Role (Github OIDC)** - Lambda 배포용
- **AWS Application Load Balancer** - 외부 트래픽 수신
- **AWS Lambda** - Webhook 처리
- **AWS Secrets Manager** - Webhook URL 저장

## ⚙️ 사전 준비

### 1. OIDC IAM Role 생성

GitHub Actions에서 AWS에 접근하기 위한 OIDC Role을 생성해야 합니다.

### 2. GitHub Secrets 설정

Repository Settings > Secrets에 다음 값들을 추가하세요:

- `AWS_OIDC_ARN` - OIDC IAM Role ARN
- `LAMBDA_FUNCTION_NAME` - Lambda 함수 이름

### 3. Terraform 변수 확인

`infrastructure/env.tfvars` 파일을 확인하고 필요한 값들을 설정하세요.

## 🚀 실행

```bash
# 인프라 구성
make apply

# 인프라 삭제
make destroy
```
