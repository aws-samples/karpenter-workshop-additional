##START,aws_dms_replication_task
resource "aws_dms_replication_task" "cdc-task" {
  cdc_start_position       = null
  cdc_start_time           = null
  migration_type           = "cdc"
  replication_instance_arn = data.aws_dms_replication_instance.aurora-s3-repinstance.arn
  replication_task_id      = "cdc-task"
  replication_task_settings = jsonencode({
    BeforeImageSettings = null
    ChangeProcessingDdlHandlingPolicy = {
      HandleSourceTableAltered   = true
      HandleSourceTableDropped   = true
      HandleSourceTableTruncated = true
    }
    ChangeProcessingTuning = {
      BatchApplyMemoryLimit         = 500
      BatchApplyPreserveTransaction = true
      BatchApplyTimeoutMax          = 30
      BatchApplyTimeoutMin          = 1
      BatchSplitSize                = 0
      CommitTimeout                 = 1
      MemoryKeepTime                = 60
      MemoryLimitTotal              = 1024
      MinTransactionSize            = 1000
      RecoveryTimeout               = -1
      StatementCacheSize            = 50
    }
    CharacterSetSettings = null
    ControlTablesSettings = {
      ControlSchema                 = ""
      FullLoadExceptionTableEnabled = false
      HistoryTableEnabled           = false
      HistoryTimeslotInMinutes      = 5
      StatusTableEnabled            = false
      SuspendedTablesTableEnabled   = false
      historyTimeslotInMinutes      = 5
    }
    ErrorBehavior = {
      ApplyErrorDeletePolicy                      = "IGNORE_RECORD"
      ApplyErrorEscalationCount                   = 0
      ApplyErrorEscalationPolicy                  = "LOG_ERROR"
      ApplyErrorFailOnTruncationDdl               = false
      ApplyErrorInsertPolicy                      = "LOG_ERROR"
      ApplyErrorUpdatePolicy                      = "LOG_ERROR"
      DataErrorEscalationCount                    = 0
      DataErrorEscalationPolicy                   = "SUSPEND_TABLE"
      DataErrorPolicy                             = "LOG_ERROR"
      DataTruncationErrorPolicy                   = "LOG_ERROR"
      EventErrorPolicy                            = "IGNORE"
      FailOnNoTablesCaptured                      = true
      FailOnTransactionConsistencyBreached        = false
      FullLoadIgnoreConflicts                     = true
      RecoverableErrorCount                       = -1
      RecoverableErrorInterval                    = 5
      RecoverableErrorStopRetryAfterThrottlingMax = true
      RecoverableErrorThrottling                  = true
      RecoverableErrorThrottlingMax               = 1800
      TableErrorEscalationCount                   = 0
      TableErrorEscalationPolicy                  = "STOP_TASK"
      TableErrorPolicy                            = "SUSPEND_TABLE"
    }
    FailTaskWhenCleanTaskResourceFailed = false
    FullLoadSettings = {
      CommitRate                      = 10000
      CreatePkAfterFullLoad           = false
      MaxFullLoadSubTasks             = 8
      StopTaskCachedChangesApplied    = false
      StopTaskCachedChangesNotApplied = false
      TargetTablePrepMode             = "DO_NOTHING"
      TransactionConsistencyTimeout   = 600
    }
    Logging = {
      EnableLogContext = true
      EnableLogging    = true
      LogComponents = [{
        Id       = "TRANSFORMATION"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "SOURCE_UNLOAD"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "IO"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "TARGET_LOAD"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "PERFORMANCE"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "SOURCE_CAPTURE"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "SORTER"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "REST_SERVER"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "VALIDATOR_EXT"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "TARGET_APPLY"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "TASK_MANAGER"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "TABLES_MANAGER"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "METADATA_MANAGER"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "FILE_FACTORY"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "COMMON"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "ADDONS"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "DATA_STRUCTURE"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "COMMUNICATION"
        Severity = "LOGGER_SEVERITY_DEFAULT"
        }, {
        Id       = "FILE_TRANSFER"
        Severity = "LOGGER_SEVERITY_DEFAULT"
      }]
      LogConfiguration = {
        EnableTraceOnError = false
        TraceOnErrorMb     = 10
      }
    }
    LoopbackPreventionSettings = null
    PostProcessingRules        = null
    StreamBufferSettings = {
      CtrlStreamBufferSizeInMB = 5
      StreamBufferCount        = 3
      StreamBufferSizeInMB     = 8
    }
    TTSettings = {
      EnableTT         = false
      TTRecordSettings = null
      TTS3Settings     = null
    }
    TargetMetadata = {
      BatchApplyEnabled            = false
      FullLobMode                  = false
      InlineLobMaxSize             = 0
      LimitedSizeLobMode           = true
      LoadMaxFileSize              = 0
      LobChunkSize                 = 0
      LobMaxSize                   = 32
      ParallelApplyBufferSize      = 0
      ParallelApplyQueuesPerThread = 0
      ParallelApplyThreads         = 0
      ParallelLoadBufferSize       = 0
      ParallelLoadQueuesPerThread  = 0
      ParallelLoadThreads          = 0
      SupportLobs                  = true
      TargetSchema                 = ""
      TaskRecoveryTableEnabled     = false
    }
  })
  resource_identifier    = null
  source_endpoint_arn    = aws_dms_endpoint.mdadb.arn
  start_replication_task = null
  table_mappings = jsonencode({
    rules = [{
      filters = []
      object-locator = {
        schema-name = "%"
        table-name  = "reviews"
      }
      rule-action = "include"
      rule-id     = "453844535"
      rule-name   = "453844535"
      rule-type   = "selection"
    }]
  })
  tags                = {}
  tags_all            = {}
  target_endpoint_arn = aws_dms_endpoint.target-s3.arn
}
