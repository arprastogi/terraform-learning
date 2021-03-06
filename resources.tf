resource "google_compute_network" "my_dev_network" {
    name = "devnetwork"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "dev-subnet-1" {
    ip_cidr_range = "10.0.1.0/24"
    name = "devsubnet1"
    network = "${google_compute_network.my_dev_network.self_link}"
    region = "us-east1"
}

resource "aws_vpc" "env-example" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags {
      Name = "terraform-aws-vpc"
    }
}

resource "aws_subnet" "subnet1" {
    cidr_block = "${cidrsubnet(aws_vpc.env-example.cidr_block, 3, 1)}"
    vpc_id = "${aws_vpc.env-example.id}"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
    cidr_block = "${cidrsubnet(aws_vpc.env-example.cidr_block, 2, 2)}"
    vpc_id = "${aws_vpc.env-example.id}"
    availability_zone = "us-east-1b"
}

resource "aws_security_group" "subnet-security" {
  vpc_id = "${aws_vpc.env-example.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${aws_vpc.env-example.cidr_block}"]
  }
}
