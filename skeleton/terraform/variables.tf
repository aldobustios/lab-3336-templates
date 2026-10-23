variable "apic_username" {
  description = "APIC labadmin username"
  type        = string
  sensitive   = true
}

variable "apic_password" {
  description = "APIC labadmin password"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "Student namespace"
  type        = string
  default     = "${{ values.namespace }}"
}

variable "gateway_name" {
  description = "Name of the API"
  type        = string
  default     = "${{ values.gateway_name }}"
}
