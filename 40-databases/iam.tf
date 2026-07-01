resource "aws_iam_role" "mysql" {
  name = "${local.common_name}-mysql"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sts:AssumeRole"
          ],
          "Principal" : {
            "Service" : [
              "ec2.amazonaws.com"
            ]
          }
        }
      ]
    }
  )
  tags = merge(
    {
      Name = "${local.common_name}-mysql"
    },
    local.common_tags
  )
}

resource "aws_iam_policy" "mysql" {
  name   = "${local.common_name}-mysql"
  policy = file("mysql_iam_policy.json")
}

resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

resource "aws_iam_instance_profile" "mysql" {
  name = "${local.common_name}-mysql"
  role = aws_iam_role.mysql.name
}