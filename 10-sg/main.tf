module "sg" {
    count = length(var.sg_names)
    source = "git::https://github.com/manoharmotam/terraform-aws-sg.git?ref=main"
    vpc_id = local.vpc_id
    project = var.project
    environment = var.environment
    sg_name = var.sg_names[count.index]
}