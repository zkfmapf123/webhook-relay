provider "aws" {

    ## <각 환경에 맞게 변경 필요>
    assume_role {
        role_arn = "arn:aws:iam::182024812696:role/TerraformAssumedRole"
    }

}