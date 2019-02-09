provider "google" {
  credentials = "${file("../gcloud-ac-key.json")}"
  project = "vlearn"
  region = "us-east1"
}

provider "aws" {
  region = "us-east-1"
}
