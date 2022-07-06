#resource "google_pubsub_topic" "example" {
#  project = "topic-project"
#  name    = "example-topic"
#}

#export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=smart-stream-subscriber-servic@cme-markets-analysis.iam.gserviceaccount.com


locals {
  customer_project = "cme-markets-analysis"
  cme_topic_project = "cmegroup-marketdata-newrel" #CME New Release Environment for Binary FIX Feeds
  #cme_topic_project = "cmegroup-marketdata-js-nr"  #CME New Release Environment for JSON Feeds

}




#Example of single stream creation
#resource "google_pubsub_subscription" "CERT-SSCL-GCP-MD-RT-CMEG-FIXBIN-v01000-INCR-310" {
#  project = local.customer_project
#  name    = "CERT.SSCL.GCP.MD.RT.CMEG.FIXBIN.v01000.INCR.310"
#  topic   = "projects/${local.cme_topic_project}/topics/CERT.SSCL.GCP.MD.RT.CMEG.FIXBIN.v01000.INCR.310"
#}


#example of multiple stream creation using configuration tf file as iterator

resource "google_pubsub_subscription" "ALL-CERT-BINARY" {
    project = local.customer_project
    for_each = var.cert_topics
    name = each.value
    topic = "projects/${local.cme_topic_project}/topics/${each.value}"
}
