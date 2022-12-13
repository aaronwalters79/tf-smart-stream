#resource "google_pubsub_topic" "example" {
#  project = "topic-project"
#  name    = "example-topic"
#}

#export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=smart-stream-subscriber-servic@YOUR-PROJECT-NAME.iam.gserviceaccount.com


locals {
  customer_project = "YOUR PROJECT NAME"  #YOUR PROJECT NAME
  cme_topic_project = "cmegroup-marketdata" #CME PRODEnvironment for Binary FIX Feeds

}




#Example of single stream creation
#resource "google_pubsub_subscription" "PROD.SSCL.GCP.MD.RT.CMEG.STRBIN.v01000.INCR.200" {
#  project = local.customer_project
#  name    = "PROD.SSCL.GCP.MD.RT.CMEG.STRBIN.v01000.INCR.200"
#  topic   = "projects/${local.cme_topic_project}/topics/PROD.SSCL.GCP.MD.RT.CMEG.STRBIN.v01000.INCR.200"
#}



#example of multiple stream creation using configuration tf file as iterator

resource "google_pubsub_subscription" "ALL-PROD-BINARY" {
    project = local.customer_project
    for_each = var.prod_topics
    name = each.value
    topic = "projects/${local.cme_topic_project}/topics/${each.value}"
}
