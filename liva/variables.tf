variable "mainVPCCIDRBlock" {
  default = "10.0.0.0/16"
}

variable "mainVPCInstanceTenancy" {
  default = "default"
}

variable "coreSNCIDRBlock" {
  default = "10.0.0.0/24"
}

variable "coreSNMapPublicIp" {
  default = true
}

variable "livaAMIId" {
  default = "ami-0aca41e2b01d8a1d3"
}