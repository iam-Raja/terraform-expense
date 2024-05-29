resource "aws_ssm_parameter" "VPC_ID" {
  name  = "/${var.project_name}/${var.environment}/VPC_ID"
  type  = "String"
  value = module.my_vpc.vpc_id
}