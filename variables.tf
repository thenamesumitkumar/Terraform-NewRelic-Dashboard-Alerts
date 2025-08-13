variable "nr_account_id" {
  description = "New Relic account ID"
  type        = number
}

variable "nr_api_key" {
  description = "New Relic API key"
  type        = string
  sensitive   = true
}

variable "nr_region" {
  description = "New Relic region (US or EU)"
  type        = string
  default     = "US"
}