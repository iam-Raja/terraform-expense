module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-backend"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_backend.value] # sg_id
  ami = data.aws_ami.ami_info.id
  subnet_id              = local.sub_private_id #subnet id(pub,priv,db)
  tags = merge (
    var.common_tags,{
        Name="${var.project_name}-${var.environment}-bastion"
    }
  )
}


module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-frontend"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_frontend.value] # sg_id
  ami = data.aws_ami.ami_info.id
  subnet_id              = local.sub_public_id #subnet id(pub,priv,db)
  tags = merge (
    var.common_tags,{
        Name="${var.project_name}-${var.environment}-frontend"
    }
  )
  }
