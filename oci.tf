provider "oci" {
  version = "~> 3.95"
  region = var.region
  #tenancy_ocid = var.tenancy_ocid
  #user_ocid = var.user_ocid
  #fingerprint = var.fingerprint
  #private_key_path = var.private_key_path
}


data "oci_identity_availability_domain" "ad" {
  compartment_id = var.compartment_ocid
  ad_number = var.availability_domain
}
