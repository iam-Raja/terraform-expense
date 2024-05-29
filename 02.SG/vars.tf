variable "project_name" {
    type=string
    default="Expense"

}

variable "Environment" {
    default = "Dev"
}

variable "common_tags" {
    type= map
default = {
    project="expense"
    Environment="dev"
    terraform=true
}
  
}