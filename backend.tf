terraform {
  backend "gcs" {
    bucket  = var.backend_bucket
    prefix  = var.backend_bucket_prefix
  }
}