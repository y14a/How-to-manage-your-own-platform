terraform {
  backend "gcs" {
    bucket = "datacenter_terraform-state"
    prefix = "production/state"
  }
}

provider "google" {
  project = "datacenter-20200301"
  region  = "asia-northeast1"
}

data "terraform_remote_state" "datacenter" {
  backend = "gcs"
  config = {
    bucket = "datacenter_terraform-state"
    prefix = "terraform/state"
  }
}
