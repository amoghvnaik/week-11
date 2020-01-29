provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "main" {
vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "EC2" {
  ami           = var.ami-id
  instance_type = var.instance-type
  key_name      = var.pem-key
  subnet_id     = "${aws_subnet.main.id}"
  associate_public_ip_address  = true
  vpc_security_group_ids = [aws_security_group.main.id]

}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-qpwoei"
  acl    = "private"

}

provider "google" {
  credentials = "${file("~/key.json")}"
  project     = "trim-plexus-258809"
  region      = "europe-west2-c"
}

resource "google_storage_bucket" "image-store" {
  name     = "image-store-bucket-qpwoei"
  location = "EU"

}


