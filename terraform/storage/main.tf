resource "aws_s3_bucket" "ldbc_bucket" {
  bucket = var.aws_bucket_name
  force_destroy = true

  tags = {
    Name        = "LDBC Data"
    Environment = "LDBC"
  }
}

resource "aws_s3_bucket_acl" "ldbc_bucket" {
  bucket = aws_s3_bucket.ldbc_bucket.id
  acl    = "private"
}

