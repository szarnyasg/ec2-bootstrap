variable "aws_bucket_name" {
    type = string
    description = "Bucket Name"
}

variable "aws_region" {
    type = string
    description = "AWS Avaibility zone"
}

variable "aws_profile" {
    type = string
    default = "default"
    description = "AWS Profile name matching the shared credentails"
}
