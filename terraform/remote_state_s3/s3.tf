resource "aws_s3_bucket" "webapp_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "${var.environment}-webapp"
  }
}


resource "aws_s3_bucket_versioning" "webapp_bucket_versioning" {
  bucket = aws_s3_bucket.webapp_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
