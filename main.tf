provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_sns_topic" "budget_alert_topic" {
    name = "budget-alert-topic"
}

resource "aws_sns_topic_subscription" "budget_email" {
    topic_arn = aws_sns_topic.budget_alert_topic.arn
    protocol  = "email"
    endpoint  = "yutaro.matsushita0402@gmail.com"
}

locals {
    budget_limits = [1, 5, 10]
}

resource "aws_budgets_budget" "monthly_budget" {
    for_each = toset([for v in local.budget_limits : tostring(v)])

    name              = "monthly-cost-budget-${each.value}"
    budget_type       = "COST"
    limit_amount      = "0.01"           # 月の予算をUSDで設定
    limit_unit        = "USD"           
    time_unit         = "MONTHLY"       # 月ごとにコストを追跡
    time_period_start = "2025-01-01_00:00"

    notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"   
    threshold           = 80.0        # 80%を超えた場合にアラート
    threshold_type      = "PERCENTAGE"
    subscriber_sns_topic_arns  = [aws_sns_topic.budget_alert_topic.arn]
    }
}
