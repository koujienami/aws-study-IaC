###############################################################################
# RDS (MySQL 8.0)
###############################################################################

resource "aws_db_subnet_group" "this" {
  name        = "aws-study-db-subnet-group"
  subnet_ids  = [aws_subnet.public_a.id, aws_subnet.public_c.id]
  description = "Subnet group for AWS Study RDS"
}

resource "aws_db_instance" "this" {
  identifier                  = "aws-study-rds"
  db_subnet_group_name        = aws_db_subnet_group.this.name
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "8.0.41"
  instance_class              = "db.t4g.micro"
  username                    = "root"
  password                    = "rootroot" # 実運用ではSecrets Manager等を利用
  db_name                     = "awsstudy"
  port                        = 3306
  backup_retention_period     = 1
  backup_window               = "15:00-16:00"
  maintenance_window          = "sun:18:00-sun:19:00"
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  vpc_security_group_ids      = [aws_security_group.rds.id]
  skip_final_snapshot         = true

  tags = {
    Name = "aws-study-rds"
  }
}
