# # waf.tf

# resource "aws_wafv2_web_acl" "web_acl" {
#   name        = "web-acl"
#   scope       = "REGIONAL" # Use "CLOUDFRONT" for CloudFront distributions
#   description = "WAF Web ACL for ALB"
#   default_action {
#     allow {}
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesSQLiRuleSet"
#     priority = 1
#     override_action {
#       none {}
#     }
#     statement {
#       managed_rule_group_statement {
#         vendor_name = "AWS"
#         name        = "AWSManagedRulesSQLiRuleSet"
#       }
#     }
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesCommonRuleSet"
#     priority = 2
#     override_action {
#       none {}
#     }
#     statement {
#       managed_rule_group_statement {
#         vendor_name = "AWS"
#         name        = "AWSManagedRulesCommonRuleSet"
#       }
#     }
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
#       sampled_requests_enabled   = true
#     }
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "web-acl"
#     sampled_requests_enabled   = true
#   }
# }

# resource "aws_wafv2_web_acl_association" "web_acl_assoc" {
#   resource_arn = aws_lb.alb.arn 
#   web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
# }
# ./