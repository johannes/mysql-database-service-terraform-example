resource "oci_core_vcn" "mds_terraform_vcn" {
  cidr_block = "10.0.0.0/16"
  dns_label = "mdsterraform"
  compartment_id = oci_identity_compartment.mds_terraform.id
  display_name = "mds_terraform_vcn"
}

resource "oci_core_internet_gateway" "internet_gateway" {
    compartment_id = oci_identity_compartment.mds_terraform.id
    vcn_id = oci_core_vcn.mds_terraform_vcn.id
    display_name = "gateway"
}

resource "oci_core_default_route_table" "default-route-table-options" {
  manage_default_resource_id = oci_core_vcn.mds_terraform_vcn.default_route_table_id

  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block          = "10.0.2.0/24"
  display_name        = "mds_tf_subnet"
  dns_label           = "mdssubnet"
  security_list_ids   = [oci_core_security_list.securitylist1.id]
  compartment_id      = oci_identity_compartment.mds_terraform.id
  vcn_id              = oci_core_vcn.mds_terraform_vcn.id
  route_table_id      = oci_core_vcn.mds_terraform_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.mds_terraform_vcn.default_dhcp_options_id
}

resource "oci_core_security_list" "securitylist1" {
  display_name   = "securitylist1"
  compartment_id = oci_identity_compartment.mds_terraform.id
  vcn_id         = oci_core_vcn.mds_terraform_vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 3306
      max = 3306
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 33060
      max = 33060
    }
  }
}
