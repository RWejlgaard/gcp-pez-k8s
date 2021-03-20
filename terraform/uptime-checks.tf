resource "google_monitoring_notification_channel" "pagerduty" {
  type = "pagerduty"
  display_name = "PagerDuty"
  sensitive_labels {
    service_key = pagerduty_service_integration.apiv2.integration_key
  }
}

resource "google_monitoring_uptime_check_config" "pezsh" {
  display_name = "http-pezsh-check"
  timeout = "60s"

  http_check {
    path = "/"
    port = 80
    request_method = "GET"
  }

  monitored_resource {
    labels = {
      "project_id" = "rwejlgaard"
      host = "www.pez.sh"
    }
    type = "uptime_url"
  }
}

resource "google_monitoring_alert_policy" "pezsh-alert" {
  enabled = true
  display_name = "${google_monitoring_uptime_check_config.pezsh.monitored_resource[0].labels.host} Uptime Checks"

  conditions {
    display_name = "Uptime Checks Failed"

    condition_threshold {
      duration = "300s"
      filter = <<-EOT
        metric.type="monitoring.googleapis.com/uptime_check/check_passed"
        resource.type="uptime_url"
        resource.label."host"="${google_monitoring_uptime_check_config.pezsh.monitored_resource[0].labels.host}"
      EOT
      comparison = "COMPARISON_GT"
      threshold_value = 0.1

      aggregations {
        alignment_period = "120s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields = [
          "resource.*"]
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }
      trigger {
        count = 1
      }
    }
  }
  combiner = "OR"

  notification_channels = [
    google_monitoring_notification_channel.pagerduty.id
  ]
}

resource "google_monitoring_uptime_check_config" "grafana" {
  display_name = "http-grafana-check"
  timeout = "60s"

  http_check {
    path = "/"
    port = 80
    request_method = "GET"
  }

  monitored_resource {
    labels = {
      "project_id" = "rwejlgaard"
      host = "grafana.pez.sh"
    }
    type = "uptime_url"
  }
}

resource "google_monitoring_alert_policy" "grafana-alert" {
  enabled = true
  display_name = "${google_monitoring_uptime_check_config.grafana.monitored_resource[0].labels.host} Uptime Checks"

  conditions {
    display_name = "Uptime Checks Failed"

    condition_threshold {
      duration = "300s"
      filter = <<-EOT
        metric.type="monitoring.googleapis.com/uptime_check/check_passed"
        resource.type="uptime_url"
        resource.label."host"="${google_monitoring_uptime_check_config.grafana.monitored_resource[0].labels.host}"
      EOT
      comparison = "COMPARISON_GT"
      threshold_value = 0.1

      aggregations {
        alignment_period = "120s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields = [
          "resource.*"]
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }
      trigger {
        count = 1
      }
    }
  }
  combiner = "OR"

  notification_channels = [
    google_monitoring_notification_channel.pagerduty.id
  ]
}

resource "google_monitoring_uptime_check_config" "cloudprober" {
  display_name = "http-cloudprober-check"
  timeout = "60s"

  http_check {
    path = "/status"
    port = 80
    request_method = "GET"
  }

  monitored_resource {
    labels = {
      "project_id" = "rwejlgaard"
      host = "cloudprober.pez.sh"
    }
    type = "uptime_url"
  }
}

resource "google_monitoring_alert_policy" "cloudprober-alert" {
  enabled = true
  display_name = "${google_monitoring_uptime_check_config.cloudprober.monitored_resource[0].labels.host} Uptime Checks"

  conditions {
    display_name = "Uptime Checks Failed"

    condition_threshold {
      duration = "300s"
      filter = <<-EOT
        metric.type="monitoring.googleapis.com/uptime_check/check_passed"
        resource.type="uptime_url"
        resource.label."host"="${google_monitoring_uptime_check_config.cloudprober.monitored_resource[0].labels.host}"
      EOT
      comparison = "COMPARISON_GT"
      threshold_value = 0.1

      aggregations {
        alignment_period = "120s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields = [
          "resource.*"]
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }
      trigger {
        count = 1
      }
    }
  }
  combiner = "OR"

  notification_channels = [
    google_monitoring_notification_channel.pagerduty.id
  ]
}