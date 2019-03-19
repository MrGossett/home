terraform {
  backend "s3" {
    region               = "us-east-1"
    bucket               = "mrgossett-terraform-state"
    key                  = "project"
    workspace_key_prefix = "env"
    dynamodb_table       = "terraform_state_lock"
  }
}
