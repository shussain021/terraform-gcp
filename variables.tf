#PROJECT
variable "project_id" {
  type    = string
}

variable "region" {
  type    = string
  default = "us-east1"
}

#BACKEND
variable "backend_bucket" {
  type    = string
  default = "terraform-tfstate-sheraz"
}

variable "backend_bucket_prefix" {
  type    = string
  default = "terraform/state"
}

#DATA NETWORK
variable "vpc_name" {
  type    = string
}

variable "subnet_name" {
  type    = string
}

#BUCKET
variable "bucket_name" {
  type    = string
}

variable "location" {
  type    = string
  default = "US"
}

#VM Instance
variable "vm_name" {
  type    = string
}

variable "machine_type" {
  type    = string
}

variable "zone" {
  type    = string
  default = "us-east1-c"
}

variable "disk_size" {
  type    = number
  default = 20
}

#SQL Instance
variable "sql_instance_name" {
  type    = string
}

variable "database_version" {
  type    = string
  default = "POSTGRES_17"
}

variable "db_type" {
  type    = string
}

variable "db_name" {
 description = "multiple db names"
 type        = list(string)
}

variable "db_username" {
  type    = string
}

variable "secret_name" {
  type    = string
}

#FW Rule VPC
variable "fw_rule" {
  type    = string
}