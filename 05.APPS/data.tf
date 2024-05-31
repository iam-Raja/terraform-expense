data "aws_ssm_parameter" "subnet_private_id" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "sg_id_backend" {
  name = "/${var.project_name}/${var.environment}/SG_ID_BACKEND"
}

data "aws_ssm_parameter" "subnet_public_id" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "sg_id_frontend" {
  name = "/${var.project_name}/${var.environment}/SG_ID_FRONTEND"
}

data "aws_ami" "ami_info" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}