# Two regions (eu-west-1) (eu-west-2)

provider "aws" {

  region = "eu-west-1"
  alias  = "euwest1"
}

provider "aws" {

  region = "eu-west-2"
  alias  = "euwest2"
}

provider "aws" {
   region =  "us-east-1"
   alias = "useast1"
}