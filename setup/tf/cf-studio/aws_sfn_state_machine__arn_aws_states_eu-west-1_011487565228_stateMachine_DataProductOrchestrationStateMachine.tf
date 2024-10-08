##START,aws_sfn_state_machine
resource "aws_sfn_state_machine" "arn_aws_states_eu-west-1_011487565228_stateMachine_DataProductOrchestrationStateMachine" {

  lifecycle {
    ignore_changes = [definition]
  }
  definition = jsonencode({
    Comment = "Data product pipeline orchestration"
    StartAt = "Parallel"
    States = {
      "Crawler Complete?" = {
        Choices = [{
          Next         = "Wait X Seconds"
          StringEquals = "RUNNING"
          Variable     = "$.Crawler.State"
          }, {
          Next = "Job Succeeded"
          Or = [{
            StringEquals = "READY"
            Variable     = "$.Crawler.State"
            }, {
            StringEquals = "STOPPING"
            Variable     = "$.Crawler.State"
          }]
        }]
        Default = "Job Failed"
        Type    = "Choice"
      }
      GetCrawler = {
        Next = "Crawler Complete?"
        Parameters = {
          Name = "dataproduct-data-crawler"
        }
        Resource = "arn:aws:states:::aws-sdk:glue:getCrawler"
        Type     = "Task"
      }
      "Job Failed" = {
        End  = true
        Type = "Pass"
      }
      "Job Succeeded" = {
        End  = true
        Type = "Pass"
      }
      Parallel = {
        Branches = [{
          StartAt = "Glue Sales Job"
          States = {
            "Glue Sales Job" = {
              End = true
              Parameters = {
                JobName = "dataproduct_sales_data"
              }
              Resource = "arn:aws:states:::glue:startJobRun.sync"
              Type     = "Task"
            }
          }
          }, {
          StartAt = "Glue Customer Job"
          States = {
            "Glue Customer Job" = {
              End = true
              Parameters = {
                JobName = "dataproduct_customers_data"
              }
              Resource = "arn:aws:states:::glue:startJobRun.sync"
              Type     = "Task"
            }
          }
        }]
        Next = "Start Product Crawler"
        Type = "Parallel"
      }
      "Start Product Crawler" = {
        Next = "Wait X Seconds"
        Parameters = {
          Name = "dataproduct-data-crawler"
        }
        Resource = "arn:aws:states:::aws-sdk:glue:startCrawler"
        Type     = "Task"
      }
      "Wait X Seconds" = {
        Next    = "GetCrawler"
        Seconds = 10
        Type    = "Wait"
      }
    }
  })
  name        = "DataProductOrchestrationStateMachine"
  name_prefix = null
  publish     = false
  role_arn    = format("arn:aws:iam::%s:role/StepFunctionsExecutionRole", data.aws_caller_identity.current.account_id)
  tags        = {}
  tags_all    = {}
  type        = "STANDARD"
  encryption_configuration {
    type = "AWS_OWNED_KEY"
  }
  logging_configuration {
    include_execution_data = false
    level                  = "OFF"
    log_destination        = null
  }
  tracing_configuration {
    enabled = false
  }
}
