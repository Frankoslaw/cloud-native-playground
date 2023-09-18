resource "oci_core_subnet" "homelab_subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.0.0.0/24"
  display_name        = "Homelab Subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.homelab_vcn.id
  route_table_id      = oci_core_route_table.homelab_route_table.id
  dns_label           = "compute"
  dhcp_options_id     = oci_core_virtual_network.homelab_vcn.default_dhcp_options_id
}
