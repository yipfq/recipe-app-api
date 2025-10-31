#=============
# ECS 
#=============

resource "aws_iam_policy" "ecs_task_execution" {
  name   = "${local.prefix}-ecs-task-execution-policy"
  path   = "/"
  policy = file("./templates/ecs/task-execution-role-policy.json")
}

resource "aws_iam_role" "ecs_task_execution" {
  name               = "${local.prefix}-ecs-task-execution-role"
  assume_role_policy = file("./templates/ecs/task-assume-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "esc_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}

resource "aws_ecs_cluster" "main" {
  name = "${local.prefix}-ecs-cluster"
}

