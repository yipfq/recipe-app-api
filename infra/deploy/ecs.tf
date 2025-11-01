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

resource "aws_iam_role" "app_task" {
  name               = "${local.prefix}-app-task-role"
  path               = "/"
  assume_role_policy = file("./templates/ecs/task-assume-role-policy.json")
}

resource "aws_iam_policy" "app_task" {
  name   = "${local.prefix}-app-task-policy"
  policy = file("./templates/ecs/task-ssm-policy.json")
}

resource "aws_iam_role_policy_attachment" "app_task" {
  role       = aws_iam_role.app_task.name
  policy_arn = aws_iam_policy.app_task.arn
}

resource "aws_ecs_cluster" "main" {
  name = "${local.prefix}-ecs-cluster"
}

resource "aws_ecs_task_definition" "api" {
  family                   = "${local.prefix}-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.app_task.arn

  container_definitions = jsonencode([])

  volume {
    name = "static"
  }

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
