variable "region" {
    description = "Please enter AWS region"
    type        = string
    default     = "us-east-2"
}

variable "instance_type" {
    description = "Please enter instance type"
    type        = string
    default     = "t2.micro"
}

/*
variable "allow_ports" {
    description = "Please list ports"
    type        = list
    default     = ["22", "443", "80"]
}
*/