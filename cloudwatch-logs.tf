resource "aws_cloudwatch_log_group" "this" {
  count = var.connection_log_options.cloudwatch_log_group == null ? 1 : 0

  region            = var.region
  name              = length(var.log_group_name) > 0 ? var.log_group_name : null
  name_prefix       = length(var.log_group_name) == 0 ? "${var.name_prefix}-" : null
  skip_destroy      = var.skip_destroy
  log_group_class   = var.log_group_class
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id
  tags              = var.tags
}

resource "aws_cloudwatch_log_stream" "this" {
  region         = var.region
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.this[0].name
}

