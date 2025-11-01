resource "aws_db_subnet_group" "main" {
  name = "${local.prefix}-main"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "${local.prefix}-db-subnet-group"
  }
}

resource "aws_security_group" "rds-sg" {
  description = "RDS access"
  name        = "${local.prefix}-rds-inbound-access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ecs_service.id
    ]
  }

  tags = {
    Name = "${local.prefix}-db-security-group"
  }
}

resource "aws_db_instance" "main" {
  identifier                 = "${local.prefix}-main"
  db_subnet_group_name       = aws_db_subnet_group.main.name
  db_name                    = "recipeapp"
  username                   = var.db_username
  password                   = var.db_password
  engine                     = "postgres"
  engine_version             = "15.9"
  skip_final_snapshot        = true
  backup_retention_period    = 0
  instance_class             = "db.t4g.micro"
  allocated_storage          = 20
  storage_type               = "gp2"
  auto_minor_version_upgrade = true
  multi_az                   = false
  vpc_security_group_ids     = [aws_security_group.rds-sg.id]


  tags = {
    Name = "${local.prefix}-rds"
  }

}
