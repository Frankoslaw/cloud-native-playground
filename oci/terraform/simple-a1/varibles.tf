variable "compartment_ocid" {
  description = "OCI Compartment ID"
  type        = string
}

variable "tenancy_ocid" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "region" {
  description = "The region to connect to. Default: eu-frankfurt-1"
  type        = string
  default     = "eu-frankfurt-1"
}

variable "path_to_public_key" {}

locals {
  flex_instance_config = {
    shape_id = "VM.Standard.A1.Flex"
    disk     = 200
    ocpus    = 4
    ram      = 24
  }
  micro_instance_config = {
    shape_id = "VM.Standard.E2.1.Micro"
    disk     = 50
    ocpus    = 1
    ram      = 1
  }
}
