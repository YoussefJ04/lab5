variable "bucket_name" {
  description = "Name of the S3 bucket for OpenTofu state"
  type        = string
}

variable "region" {
  description = "AWS region where to create the bucket"
  type        = string
}
