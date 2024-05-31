module "frontend"{
    source="git::https://github.com/iam-Raja/terraform-module-SG-Source.git?ref=main"
    project_name=var.project_name
    environment = var.environment
    sg_name="frontend"
    sg_description="sg is for Frontend"
    vpc_id=data.aws_ssm_parameter.vpc_id.value
    common_tags=var.common_tags
}

module "backend"{
    source="git::https://github.com/iam-Raja/terraform-module-SG-Source.git?ref=main"
    project_name=var.project_name
    environment = var.environment
    sg_name="backend"
    sg_description="sg is for backend"
    vpc_id=data.aws_ssm_parameter.vpc_id.value
    common_tags=var.common_tags
}

module "db"{
    source="git::https://github.com/iam-Raja/terraform-module-SG-Source.git?ref=main"
    project_name=var.project_name
    environment = var.environment
    sg_name="db"
    sg_description="sg is for db"
    vpc_id=data.aws_ssm_parameter.vpc_id.value
    common_tags=var.common_tags
}

module "bastion"{
    source="git::https://github.com/iam-Raja/terraform-module-SG-Source.git?ref=main"
    project_name=var.project_name
    environment = var.environment
    sg_name="bastion"
    sg_description="sg is for bastion"
    vpc_id=data.aws_ssm_parameter.vpc_id.value
    common_tags=var.common_tags
}

module "ansible"{
    source="git::https://github.com/iam-Raja/terraform-module-SG-Source.git?ref=main"
    project_name=var.project_name
    environment = var.environment
    sg_name="ansible"
    sg_description="sg is for ansible"
    vpc_id=data.aws_ssm_parameter.vpc_id.value
    common_tags=var.common_tags
}

# frontend sg is accepting traffic from internet

resource "aws_security_group_rule" "frontend_internet" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.frontend.sg_id #to sg we were creating this rule
  cidr_blocks=["0.0.0.0/0"] ##from where traffic is coming
}

resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.frontend.sg_id #to sg we were creating this rule
  source_security_group_id=module.ansible.sg_id ##from where traffic is coming
}

# backend sg is accepting from instnce which are connected to frontend sg
resource "aws_security_group_rule" "backend_frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.backend.sg_id #to sg we were creating this rule
  source_security_group_id=module.frontend.sg_id ##from where traffic is coming
}

resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.backend.sg_id #to sg we were creating this rule
  source_security_group_id=module.bastion.sg_id ##from where traffic is coming
}

resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.backend.sg_id #to sg we were creating this rule
  source_security_group_id=module.ansible.sg_id ##from where traffic is coming
}

# db sg is accepting trafic from from instnce which are connected to backend sg
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.db.sg_id #to sg we were creating this rule
  source_security_group_id=module.backend.sg_id ##from where traffic is coming
}

resource "aws_security_group_rule" "db_bastion" { #here bastion to check connectivity of db
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.db.sg_id #to sg we were creating this rule
  source_security_group_id=module.bastion.sg_id ##from where traffic is coming
}

# ansible sg is accepting traffic from public

resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.db.sg_id #to sg we were creating this rule
  cidr_blocks=["0.0.0.0/0"] ##from where traffic is coming
}

# bastion sg is accepting traffic from public

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.bastion.sg_id #to sg we were creating this rule
  cidr_blocks=["0.0.0.0/0"] ##from where traffic is coming
}
