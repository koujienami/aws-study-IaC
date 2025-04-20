###############################################################################
# CloudWatch Alarm
###############################################################################

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name          = "aws-study-cpu-utilization-alarm"
  alarm_description   = "Aws-Study EC2のCPU使用率が 70%以上になりました。"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 300
  threshold           = 70
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  treat_missing_data  = "missing"
  unit                = "Percent"
  alarm_actions       = ["arn:aws:sns:ap-northeast-1:913925038760:AWS-Study-Topic"]

  dimensions = {
    InstanceId = aws_instance.this.id
  }
}
