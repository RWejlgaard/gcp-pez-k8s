resource "pagerduty_user" "me" {
  name  = "Rasmus Knudsen"
  role = "owner"
  description = ""
  email = "pez@pez.sh"
}

resource "pagerduty_escalation_policy" "default" {
  name      = "Default"
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 10
    target {
      type = "user_reference"
      id   = pagerduty_user.me.id
    }
  }
}

resource "pagerduty_service" "k8s" {
  name = "k8s"
  escalation_policy = pagerduty_escalation_policy.default.id
  alert_creation = "create_alerts_and_incidents"
}

resource "pagerduty_service_integration" "apiv2" {
  name = "GCP"
  type = "events_api_v2_inbound_integration"
  service = pagerduty_service.k8s.id
}

