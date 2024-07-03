variable "location" {
  description = " (Required) The location/region where the resouce is created. Changing this forces a new resource to be created."
  type        = string
  default     = "francecentral"
}

variable "vnet_hub_address_space" {
  default     = ["10.2.0.0/16"]
  description = "The address space that is used in the virtual network. More than one address space can be provisioned"
  type        = list(string)
}
variable "vnet_spoke_address_space" {
  default     = ["10.1.0.0/16"]
  description = "The address space that is used in the virtual network. More than one address space can be provisioned"
  type        = list(string)
}
