resource "google_compute_instance" "firstserver" {
  name = "thefirstserver"
  machine_type = "n1-standard-1"
  zone = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.dev-subnet-1.name}"

    access_config {

    }
  }
  metadata {
    foo = "bar"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name = "virtualization_type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "secondserver" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"

    tags {
      Name = "secondserver"
      Type = "test"
    }
    subnet_id = "${aws_subnet.subnet1.id}"
}
