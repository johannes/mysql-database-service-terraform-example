resource "oci_identity_compartment" "mds_terraform" {
  name           = "mds_terraform"
  description    = "Compartment to house the MySQL Database and Terraform experiment"
  compartment_id = var.compartment_ocid
  enable_delete = true
}
