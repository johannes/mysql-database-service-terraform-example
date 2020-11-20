
data "oci_core_images" "images_for_shape" {
  compartment_id = oci_identity_compartment.mds_terraform.id
  operating_system = "Oracle Linux"
  operating_system_version = "7.8"
  shape = var.compute_shape
  sort_by = "TIMECREATED"
  sort_order = "DESC"
}

resource "oci_core_instance" "compute_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id = oci_identity_compartment.mds_terraform.id
  display_name = "MySQL Database Service and Terraform Test"
  shape = var.compute_shape

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.images_for_shape.images[0].id
  }

  create_vnic_details {
    assign_public_ip = true
    display_name     = "primaryVnic"
    subnet_id        = oci_core_subnet.test_subnet.id
    hostname_label   = "compute"
  }

  metadata = {
    ssh_authorized_keys = var.public_key
    user_data = filebase64("init-scripts/compute-init.sh")
  }
}

output "compute_public_ip" {
  value =  oci_core_instance.compute_instance.public_ip
}

