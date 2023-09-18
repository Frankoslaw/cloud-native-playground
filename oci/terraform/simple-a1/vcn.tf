resource "oci_core_virtual_network" "homelab_vcn" {
  cidr_block     = "10.0.0.0/16"
  dns_label      = "homelab"
  compartment_id = var.compartment_ocid
  display_name   = "Homelab VCN"
}

resource "oci_core_internet_gateway" "homelab_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "Homelab GATEWAY"
  vcn_id         = oci_core_virtual_network.homelab_vcn.id
}

resource "oci_core_route_table" "homelab_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.homelab_vcn.id
  display_name   = "Homelab ROUTE TABLE"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.homelab_gateway.id
  }
}
