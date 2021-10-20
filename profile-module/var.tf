variable "name" {
  description = "Name prefix for the resources of this stack"
}


variable "organization_name" {
  description = "Name of organization to use in private certificate"
  default     = "ACME, Inc"
}
