data "oci_mysql_mysql_configurations" "shape" {
    compartment_id = oci_identity_compartment.mds_terraform.id
    type = ["DEFAULT"]
    shape_name = var.mysql_shape
}

resource "oci_mysql_mysql_db_system" "mds_terraform" {
    display_name = "Terraform Experiment"
    admin_username = var.mysql_admin_user
    admin_password = var.mysql_admin_password
    shape_name = var.mysql_shape
    configuration_id =data.oci_mysql_mysql_configurations.shape.configurations[0].id
    subnet_id = oci_core_subnet.test_subnet.id
    compartment_id = oci_identity_compartment.mds_terraform.id
    availability_domain = data.oci_identity_availability_domain.ad.name
    data_storage_size_in_gb = var.mysql_data_storage_in_gb
}

output "mysql_url" {
  value =  "mysqlx://${var.mysql_admin_user}:${var.mysql_admin_password}@${oci_mysql_mysql_db_system.mds_terraform.ip_address}:${oci_mysql_mysql_db_system.mds_terraform.port_x}"
}
