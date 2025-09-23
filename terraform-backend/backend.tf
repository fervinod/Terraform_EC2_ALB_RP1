

terraform {
  backend "s3" {
    bucket = "vinod-s3-tfstate-demo"
    key = "statefile/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-lock"
    
  }
}