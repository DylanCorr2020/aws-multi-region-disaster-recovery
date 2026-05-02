terraform {
  backend "s3" {
    bucket = "aws-multi-region-dr-state"
    key    = "terrform_state"
    region = "eu-west-1"

    #enable S3 native locking 
    use_lockfile = true

  }
}

