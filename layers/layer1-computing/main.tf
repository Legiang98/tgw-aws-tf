data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket  = "tfsate-tgw-demo-bucket"
    key     = "layer0-networking"
    region  = "us-east-1"
    encrypt = true
  }
}

locals {
  subnet_ids         = data.terraform_remote_state.networking.outputs.subnet_ids
  security_group_ids = data.terraform_remote_state.networking.outputs.security_group_ids
}
