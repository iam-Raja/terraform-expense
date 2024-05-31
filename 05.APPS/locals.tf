locals {
    ## converting stringlist to string and getting first element
  sub_private_id=element(split(",", data.aws_ssm_parameter.subnet_private_id.value), 0) 
  sub_public_id=element(split(",", data.aws_ssm_parameter.subnet_public_id.value), 0) 
}