# IAM app policies
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html
data "aws_iam_policy_document" "assume" {
  statement {
    sid     = "Assume"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "container_exec_allow" {
  statement {
    sid    = "ExecAllow"
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "container_exec_allow" {
  name        = "container_exec_allow_${var.service_name}"
  description = "Policy to allow ECS exec feature"
  path        = "/ecs/"
  policy      = data.aws_iam_policy_document.container_exec_allow.json
}

resource "aws_iam_role" "exec" {
  name               = "${var.service_name}-ecs-task-execution-role"
  description        = "${var.service_name} ECS task execution role"
  path               = "/ecs/"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_role" "task" {
  name               = "${var.service_name}-ecs-task-role"
  description        = "${var.service_name} ECS task role"
  path               = "/ecs/"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_role_policy_attachment" "exec" {
  role       = aws_iam_role.exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "container_exec_allow" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.container_exec_allow.arn
}
