###############################################################################
# Terraform Native Tests for AWS‑Study Stack
# Tested with Terraform 1.6.x (`terraform test`)
###############################################################################

run "plan" {
  command = plan  # Dry‑run; validates planned values without creating resources

  ###########################################################################
  # Networking
  ###########################################################################
  assert {
    condition     = aws_vpc.this.cidr_block == "10.2.0.0/16"
    error_message = "VPC の CIDR が 10.2.0.0/16 ではありません。"
  }

  ###########################################################################
  # Compute
  ###########################################################################
  assert {
    condition     = aws_instance.this.instance_type == "t2.micro"
    error_message = "EC2 インスタンスタイプが t2.micro ではありません。"
  }

  ###########################################################################
  # Database
  ###########################################################################
  assert {
    condition     = aws_db_instance.this.engine == "mysql"
    error_message = "RDS エンジンが MySQL ではありません。"
  }

  assert {
    condition     = aws_db_instance.this.instance_class == "db.t4g.micro"
    error_message = "RDS インスタンスクラスが db.t4g.micro ではありません。"
  }

  assert {
    condition     = aws_db_instance.this.backup_retention_period == 1
    error_message = "RDS のバックアップ保持期間が 1 日ではありません。"
  }

  ###########################################################################
  # Load Balancer
  ###########################################################################
  assert {
    condition     = aws_lb_listener.http.port == 80
    error_message = "ALB リスナーのポートが 80 ではありません。"
  }

  ###########################################################################
  # Security / Compliance
  ###########################################################################
  assert {
    condition     = aws_wafv2_web_acl.this.scope == "REGIONAL"
    error_message = "WAFv2 WebACL が REGIONAL スコープで作成されていません。"
  }

  ###########################################################################
  # Monitoring
  ###########################################################################
  assert {
    condition     = aws_cloudwatch_metric_alarm.ec2_cpu.threshold == 70
    error_message = "EC2 CPU アラームの閾値が 70% ではありません。"
  }
}
