
# ------------------------------
# Database Configuration
# ------------------------------
resource "aws_db_subnet_group" "main" {
  name = "main"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_c.id,
  ]

}

resource "aws_security_group" "rds" {
  description = "Allow access to RDS"
  name        = "rds"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_db_instance" "postgres" {
  identifier              = "macha-db"
  db_name                 = "postgres"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "17.4"
  instance_class          = "db.t4g.micro"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  password                = var.db_password
  username                = var.db_username
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true
  copy_tags_to_snapshot        = false
  storage_encrypted            = false
  performance_insights_enabled = false
  vpc_security_group_ids  = [aws_security_group.rds.id]

  tags = {
    Name = "PostgreSQL 17.4 DB"
  }
}

output "rds_endpoint" {
  description = "RDS のエンドポイント"
  value       = aws_db_instance.postgres.address
}