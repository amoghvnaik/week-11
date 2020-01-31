resource "aws_lambda_function" "s3" {
    filename = "../../modules/lambda/s3.zip"
    function_name = "s3"
    role = "arn:aws:iam::239302522954:role/LambdaRole"
    handler = "s3.lambda_handler"
    runtime = "python3.8"
    tags = {
      Name = "${var.environment}-${var.region}-Private"
    }
}

resource "aws_cloudwatch_event_rule" "schedule" {
    name = "schedule"
    schedule_expression = var.cloud
}

resource "aws_cloudwatch_event_target" "schedule" {
    rule = aws_cloudwatch_event_rule.schedule.name
    target_id = "schedule"
    arn = aws_lambda_function.s3.arn
    input = <<DOC
  {
    "json": [
    {"name":"var.region"}
    ]
  }
DOC
}

resource "aws_lambda_permission" "permission" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.s3.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.schedule.arn
}
