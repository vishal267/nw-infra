terraform {
  backend "s3" {
	bucket = "nwwk8s-tf"
	key	= "prod/remote_bucket_s3"
	region = "ap-south-1"
  }
}
