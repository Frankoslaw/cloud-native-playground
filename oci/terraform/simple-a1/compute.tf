resource "oci_core_instance" "homelab_oci_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "Homelab - Compute A1 MAX"
  shape               = local.flex_instance_config.shape_id

  source_details {
    source_id               = data.oci_core_images.ubuntu_aarch64_os_images.images.0.id
    source_type             = "image"
    boot_volume_size_in_gbs = local.flex_instance_config.disk
  }

  shape_config {
    memory_in_gbs = local.flex_instance_config.ram
    ocpus         = local.flex_instance_config.ocpus
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.homelab_subnet.id
    display_name     = "Primary VNIC"
    assign_public_ip = true
    hostname_label   = "homelab-compute-a1-max"
    nsg_ids          = [oci_core_network_security_group.homelab.id]
    private_ip       = "10.0.0.100"
  }

  extended_metadata = {
    roles = "masters"
    user_data = base64encode(
      templatefile("${path.module}/templates/ubuntu.tpl.yml",
        {
          ssh_authorized_keys = file(var.path_to_public_key)
        }
    ))
    tags = "group:master"
  }

  connection {
    type = "ssh"
    user = "kube"
    host = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }

  freeform_tags = {
    "master" : true
  }
}
