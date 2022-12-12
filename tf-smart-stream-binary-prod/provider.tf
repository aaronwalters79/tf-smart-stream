
#reference: https://cloud.google.com/blog/topics/developers-practitioners/using-google-cloud-service-account-impersonation-your-terraform-code

#locals {
# terraform_service_account = "YOUR_SERVICE_ACCOUNT@YOUR_PROJECT.iam.gserviceaccount.com"
# terraform_service_account = "smart-stream-subscriber-servic@cme-markets-analysis.iam.gserviceaccount.com"
# customer_project=cme-markets-analysis 
#}


#provider "google" {
# alias = "impersonation"
# scopes = [
#   "https://www.googleapis.com/auth/cloud-platform"",
#   "https://www.googleapis.com/auth/userinfo.email"",
# ]
#}



#data "google_service_account_access_token" "default" {
# provider               	= google.impersonation
# target_service_account 	= local.terraform_service_account
# scopes                 	= ["userinfo-email"", "cloud-platform"]
# lifetime               	= "1200s"
#}



#provider "google" {
# project 		= cme-markets-analysis
# access_token	= data.google_service_account_access_token.default.access_token
# request_timeout 	= "60s"
#}

