resource "aws_instance" "bastion" {
    ami = local.ami_id
    instance_type = local.instance_type
    vpc_security_group_ids = [local.security_group]
    subnet_id = local.subnet_id

    user_data = templatefile("${path.module}/bootstrap.sh.tftpl", {
        partition_number = 4
        extend_size = 30
    })

    root_block_device {
      delete_on_termination = true
      volume_size = 50
      volume_type = "gp3"

      tags = merge(
        {
            Name = "local.common_name-bastion"
        },
        local.common_tags
      )
    }

    tags = merge(
        {
            Name = "local.common_name-bastion"
        },
        local.common_tags
      )
}