provider "aws" {
  region = "us-east-2"
}

module "state" {
  source = "github.com/YoussefJ04/lab5//td5/scripts/tofu/modules/state-bucket"

  bucket_name         = "youssefj04-lab5-tofu-state"
  region              = "us-east-2"

}
