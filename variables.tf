#AWS config

variable "aws_access_key" {
  default = "AKIA4IJZG5EUJYZOQUBR"
}

variable "aws_secret_key" {
  default = "AYwQLURz5VCNsrfbDjxRDw+ne/eLQWxArqmifpP3"
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "availabilityZone" {
        default = "ap-south-1a"
}

variable "instanceTenancy" {
 default = "default"
}
variable "dnsSupport" {
 default = true
}
variable "dnsHostNames" {
        default = true
}
variable "vpcCIDRblock" {
 default = "10.0.0.0/16"
}

variable "subnetCIDRblock" {
        default = "10.0.1.0/24"
}

variable "destinationCIDRblock" {
        default = "0.0.0.0/0"
}

variable "ingressCIDRblock" {
        type = "list"
        default = [ "0.0.0.0/0" ]
}

variable "mapPublicIP" {
        default = true
}

