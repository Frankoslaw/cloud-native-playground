resource "oci_core_network_security_group" "homelab" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.homelab_vcn.id
  #Optional
  display_name = "Homelab NSG"
}

resource "oci_core_network_security_group_security_rule" "homelab_egress" {
  network_security_group_id = oci_core_network_security_group.homelab.id
  direction                 = "EGRESS"
  destination               = "0.0.0.0/0"
  protocol                  = "all"
}

resource "oci_core_network_security_group_security_rule" "homelab_ingress_vcn" {
  network_security_group_id = oci_core_network_security_group.homelab.id
  direction                 = "INGRESS"
  source                    = "10.0.0.0/16"
  protocol                  = "all" # ALL
}

resource "oci_core_network_security_group_security_rule" "homelab_ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.homelab.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "homelab_ingress_apiserver" {
  network_security_group_id = oci_core_network_security_group.homelab.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "homelab_ingress_http" {
  network_security_group_id = oci_core_network_security_group.homelab.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "homelab_ingress_https" {
  network_security_group_id = oci_core_network_security_group.homelab.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}
