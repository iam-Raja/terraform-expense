resource "aws_ssm_parameter" "SG_ID_FRONTEND" {
  name  = "/${var.project_name}/${var.environment}/SG_ID_FRONTEND"
  type  = "String"
  value = module.frontend.sg_id
}


resource "aws_ssm_parameter" "SG_ID_BACKEND" {
  name  = "/${var.project_name}/${var.environment}/SG_ID_BACKEND"
  type  = "String"
  value = module.backend.sg_id
}


resource "aws_ssm_parameter" "SG_ID_DB" {
  name  = "/${var.project_name}/${var.environment}/SG_ID_DB"
  type  = "String"
  value = module.db.sg_id
}

resource "aws_ssm_parameter" "SG_ID_BASTION" {
  name  = "/${var.project_name}/${var.environment}/SG_ID_BASTION"
  type  = "String"
  value = module.bastion.sg_id
}

resource "aws_ssm_parameter" "SG_ID_ANSIBLE" {
  name  = "/${var.project_name}/${var.environment}/SG_ID_ANSIBLE"
  type  = "String"
  value = module.ansible.sg_id
}