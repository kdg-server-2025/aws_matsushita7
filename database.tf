
# ------------------------------
# Database Configuration
# ------------------------------
# resource "aws_db_subnet_group" "rds_subnet_group" {
#   name = "rds_subnet_group"
#   subnet_ids = [
#     aws_subnet.private_a.id,
#     aws_subnet.private_c.id,
#     aws_subnet.public_a.id,
#   ]

# }



resource "aws_db_instance" "postgres" {
  identifier              = "macha-db"
  db_name                 = "postgres"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "17.4"
  instance_class          = "db.t4g.micro"
  password                = var.db_password
  username                = var.db_username
  backup_retention_period = 0
  
  multi_az                = false

  # 追加の費用が掛かることを防止するため snapshot と Performance Insights は無効にする
  skip_final_snapshot     = true
  copy_tags_to_snapshot        = false
  storage_encrypted            = false
  performance_insights_enabled = false

  # 
  vpc_security_group_ids  = [aws_security_group.rds_enable.id]
  publicly_accessible = true

  tags = {
    Name = "PostgreSQL 17.4 DB"
  }
}

output "rds_endpoint" {
  description = "RDS のエンドポイント"
  value       = aws_db_instance.postgres.address
}