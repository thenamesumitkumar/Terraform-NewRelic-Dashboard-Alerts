terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.38.0"
    }
  }
}

provider "newrelic" {
  account_id = var.nr_account_id
  api_key    = var.nr_api_key
  region     = var.nr_region
}

resource "newrelic_one_dashboard" "tf_dashboard" {
  name        = "Terraform VM Overview"
  permissions = "public_read_write"

  page {
    name = "VM Metrics"

    widget_line {
      title  = "CPU Usage (%)"
      row    = 1
      column = 1
      width  = 6
      height = 3

      nrql_query {
        query = "FROM SystemSample SELECT average(cpuPercent) WHERE hostname = 'POC-VM-Test' TIMESERIES"
      }
    }

    widget_line {
      title  = "Memory Usage (%)"
      row    = 1
      column = 7
      width  = 6
      height = 3

      nrql_query {
        query = "FROM SystemSample SELECT average(memoryUsedPercent) WHERE hostname = 'POC-VM-Test' TIMESERIES"
      }
    }

    widget_line {
      title  = "Disk Used (%)"
      row    = 2
      column = 1
      width  = 6
      height = 3

      nrql_query {
        query = "FROM StorageSample SELECT average(diskUsedPercent) WHERE hostname = 'POC-VM-Test' TIMESERIES"
      }
    }
  }
}