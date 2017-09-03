# First terraform
# 
# https://cloud.google.com/community/tutorials/managing-gcp-projects-with-terraform
# https://www.terraform.io/docs/providers/google/r/compute_instance.html
#

data "google_compute_zones" "available" {}
 
variable "project_name" {}

provider "google" {
 version     = "~> 0.1"
 credentials = "${file("account.json")}"
 project     = "${var.project_name}"
 region      = "us-central1"
}

resource "google_compute_instance" "default" {
 name = "tf-compute-1"
 machine_type = "f1-micro"
 zone = "us-central1-a"
 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-8"
   }
 }
 network_interface {
   network = "default"
   access_config {
   }
 }
 metadata {
   foo = "bar"
 }
 metadata_startup_script = "echo hi > /test.txt"
}
 
output "instance_id" {
 value = "${google_compute_instance.default.self_link}"
}
