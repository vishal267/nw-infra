terraform {
  backend "s3" {
	bucket = "nwk8s-terraform"
	key	= "prod/remote_bucket_s3"
	region = "ap-south-1"
  }
}
