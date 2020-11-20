variable "region" {}

variable "compartment_ocid" {}

variable "mysql_admin_user" {
    default = "root"
}

variable "mysql_admin_password" {
}

variable "mysql_shape" {
    default = "VM.Standard.E2.1"
}

variable "mysql_data_storage_in_gb" {
    default = 50
}

variable "availability_domain" {
  default = 1
}

variable "compute_shape" {
  default ="VM.Standard2.1"
}

#variable "public_key" { }

#variable "tenancy_ocid" {}

#variable "user_ocid" {}

#variable "fingerprint" {}

#variable "private_key_path" {}

