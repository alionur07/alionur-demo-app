resource "aws_db_subnet_group" "alionur-demo-app-db" {
  name       = "alionur-demo-app-db"
  subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnets

  tags = {
    Name = "alionur-demo-app-db"
  }
}

resource "aws_security_group" "rds" {
  name   = "alionur-demo-app-db_rds"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alionur-demo-app-db_rds"
  }
}

resource "aws_db_parameter_group" "alionur-demo-app-db" {
  name   = "alionur-demo-app-db"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "alionur-demo-app-db" {
  identifier             = "alionur-demo-app-db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.alionur-demo-app-db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.alionur-demo-app-db.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}