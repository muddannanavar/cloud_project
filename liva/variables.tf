variable "mainVPCCIDRBlock" {
  default = "10.0.0.0/16"
}

variable "mainVPCInstanceTenancy" {
  default = "default"
}

variable "coreSNCIDRBlock" {
  default = "10.0.0.1/24"
}

variable "coreSNMapPublicIp" {
  default = true
}