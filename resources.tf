resource "google_compute_network" "my_dev_network" {
    name = "devnetwork"
    auto_create_subnetworks = false
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
