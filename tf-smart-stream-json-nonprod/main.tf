#resource "google_pubsub_topic" "example" {
#  project = "topic-project"
#  name    = "example-topic"
#}

locals {
  customer_project = "cme-markets-analysis"
  #cme_topic_project = "cmegroup-marketdata-newrel" #CME New Release Environment for Binary FIX Feeds
  cme_topic_project = "cmegroup-marketdata-js-nr"  #CME New Release Environment for JSON Feeds}




#Example of single stream creation
#resource "google_pubsub_subscription" "CERT-SSCL-GCP-MD-RT-CMEG-FIXBIN-v01000-INCR-310" {
#  project = local.customer_project
#  name    = "NR.SSCL.GCP.MD.RT.CMEG.JSON.v01000.TOB.XCME.2GT"
#  topic   = "projects/${local.cme_topic_project}/topics/NR.SSCL.GCP.MD.RT.CMEG.JSON.v01000.TOB.XCME.2GT"
#}


#xample of multiple stream creation

resource "google_pubsub_subscription" "ALL-NR-JSON" {
    project = local.customer_project
    for_each = var.cert_topics
    name = each.value
    topic = "projects/${local.cme_topic_project}/topics/${each.value}"

}
