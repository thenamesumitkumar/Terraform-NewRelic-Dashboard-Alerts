resource "newrelic_alert_policy" "vm_alert_policy" {
  name = "Terraform VM Alerts"
}

resource "newrelic_nrql_alert_condition" "cpu_high" {
  name       = "High CPU Usage"
  policy_id  = newrelic_alert_policy.vm_alert_policy.id
  type       = "static"

  nrql {
    query = "FROM SystemSample SELECT average(cpuPercent) WHERE hostname = 'POC-VM-Test'"
  }

  critical {
    threshold               = 80
    threshold_duration      = 300
    threshold_occurrences   = "AT_LEAST_ONCE"
    operator                = "ABOVE"
  }

  violation_time_limit_seconds = 3600
}

resource "newrelic_nrql_alert_condition" "memory_high" {
  name       = "High Memory Usage"
  policy_id  = newrelic_alert_policy.vm_alert_policy.id
  type       = "static"

  nrql {
    query = "FROM SystemSample SELECT average(memoryUsedPercent) WHERE hostname = 'POC-VM-Test'"
  }

  critical {
    threshold               = 90
    threshold_duration      = 300
    threshold_occurrences   = "AT_LEAST_ONCE"
    operator                = "ABOVE"
  }

  violation_time_limit_seconds = 3600
}
resource "newrelic_alert_channel" "email_alert" {
  name = "Sumit Email Alerts"
  type = "email"

  config {
    recipients              = "hellosumitkumar@outlook.com"
    include_json_attachment = "false"
  }
}
resource "newrelic_alert_policy_channel" "link_email" {
  policy_id   = newrelic_alert_policy.vm_alert_policy.id
  channel_ids = [newrelic_alert_channel.email_alert.id]
}
