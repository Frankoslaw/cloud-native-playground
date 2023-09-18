output "flex_instance_public_ip" {
  value = oci_core_instance.homelab_oci_instance.*.public_ip
}
