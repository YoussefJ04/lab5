terraform {
  backend "s3" {
    bucket         = "youssefj04-lab5-tofu-state"
    key            = "td5/scripts/tofu/live/tofu-state"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "youssefj04-lab5-tofu-state-locks"
  }
}

