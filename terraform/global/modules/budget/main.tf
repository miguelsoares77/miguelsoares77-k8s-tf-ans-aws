## BUDGETS
resource "aws_budgets_budget" "pobre" {
  name                = "monthly-budget"
  budget_type         = "COST"
  limit_amount        = "5.0"
  limit_unit          = "USD"
  time_unit           = "MONTHLY"
  time_period_start   = "2026-06-16_00:01"
}