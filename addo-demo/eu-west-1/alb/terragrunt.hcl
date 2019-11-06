terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-alb.git?ref=v4.1.0"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", "../security-group_2"]
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "security-group_2" {
  config_path = "../security-group_2"
}

###########################################################
# View all available inputs for this module:
# https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/4.1.0?tab=inputs
###########################################################
inputs = {
  # The resource name and Name tag of the load balancer.
  # type: string
  load_balancer_name = "pet-amoeba"

  # Controls if the ALB will log requests to S3.
  # type: bool
  logging_enabled = false

  # The security groups to attach to the load balancer. e.g. ["sg-edcd9784","sg-edcd9785"]
  # type: list(string)
  security_groups = [dependency.security-group_2.outputs.this_security_group_id]

  # A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']
  # type: list(string)
  subnets = dependency.vpc.outputs.public_subnets

  # VPC id where the load balancer and other resources will be deployed.
  # type: string
  vpc_id = dependency.vpc.outputs.vpc_id

  
}
