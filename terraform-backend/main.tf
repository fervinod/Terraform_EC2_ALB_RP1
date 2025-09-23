resource "aws_vpc" "myvpc1" {
    cidr_block = var.cidr
  
}

resource "aws_subnet" "vmfsub1" {
    vpc_id = aws_vpc.myvpc1.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    assign_ipv6_address_on_creation = false
    
}

/*
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc1.id
  
}
*/

#EC2
resource "aws_instance" "ec2inst1" {
  ami = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.vmfsub1.id
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket = "vinod-s3-tfstate-demo" 
}


resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
