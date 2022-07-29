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

resource "aws_s3_bucket_public_access_block" "ldbc_bucket" {
  bucket = aws_s3_bucket.ldbc_bucket.id

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
}
