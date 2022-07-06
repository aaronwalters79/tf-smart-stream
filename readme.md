# CME Smart Stream Configuration via Terraform Templates 

This repo contains working examples on using Terraform via [Google Cloud Shell](https://cloud.google.com/shell) to setup subscriptions to [CME Smart Stream market data delivery solutions](https://www.cmegroup.com/market-data/connect-data/cloud-mdp.html)

The goal is to demonstrate how you as a customer of the CME Smart Stream and Google Cloud services can quickly enable the connection between CME publishing content to specific Cloud PubSub Topics and access via a _Subscription_ in your specific Google Cloud project. 

As background, this is my first attempt at using [Terraform](https://www.terraform.io/) and was really surprised at the ease of use for repeatable deployments. I welcome feedback or improvements from the community.  

# Primary Process and Steps

1. Create and correctly permission a Service Account in your GCP Project
1. Create a CME Smart Stream access request to the CME development environments called CERT and New Release
1. Copy this repo to your Google Cloud Shell environment
1. Configure variables 
1. Run terraform


# 1 Create Service Account in your GCP Project

1. Login to cloud.google.com and navigate to IAM & Admin in the side menu, then select Service Accounts.
1. Create a Service Account by Clicking 'Create Service Account'
1. In step 1 of the screen, give it a name.  I typically use something descriptive like _MySmartStreamServiceAcct_.  click create and continue.
1. In step 2, add the role of _pub/sub admin_ as this will enable the service account to do anything in Google Cloud Pub/Sub include create subscriptions, delete subscriptions, and read from the subscription.
1. Finally, if you plan on using these scripts within your personal GCP login, navigate to IAM, find your personal login listed and click the pencil icon on the far right. Add _Service Account Token Creator_ to your role.  This will enable you to directly act as the service account when logged into the console.


# 2 Create CME Smart Stream access request via CME
Now that you have a Service Account, you must create an order with CME and supply the Service Account alias in that process. Your alias for your Service Account will look something like: SERVICEACCOUNTNAME@YOURROJECTNAME.iam.gserviceaccount.com

You will need to establish a CME account and order the services.  All customers must start with Certification onboarding which is a free environment that allows for development.  (CME Data Products Onboarding)[https://dataservices.cmegroup.com/en-us/Data-Products]

# 3 Copy Repo
<INSERT Git Copy Statements Here When Posted>

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/aaronwalters79/tf-smart-stream.git)



# 4 Configure Critical Variables in  Terrform Script

Set the environment variable so that Terraform knows to use your Service Account and not your current user account.  Replace SERVICE ACCOUNT ALIAS and YOURPROJECT with your specific service account alias used when onboarding to the CME Service and created in Step 1.


'''$ export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=SERVICE-ACCOUNT-ALIAS@YOURPROJECTNAME.iam.gserviceaccount.com

'''

There are several root folders supplied in the script, 1 for non-production connections to FIX Binary data, 1 for non-production connections to JSON data, 1 for production FIX Binary Data, and 1 for product JSON data. These are nearly the same scripts with the only changes being the specific project hosting the Topics (found in the main.tf file) as well as the list of Topic names in each environment found in the (found in the *-vars.tf file).

For example, navigate to the binary directory for nonprod data
'''
$ cd tf-smart-stream-binary-nonprod

'''


Update your project name in 'main.tf' files within the folder for the type of data feeds you want (FIX Binary or JSON).  This is used to ensure you create the subscriptions in your Google Cloud project.  

'''

locals {
  customer_project = "YOURPROJECTNAME"
  ...
  }

'''


# 5 Connect
Run Terraform Init, Terrafrom Plan, and then Terraform Apply

'''
$ terraform init
$ terraform plan
$ terraform apply

'''


# What is really happening

The Terraform is using configuration set in the *-*-var.tf file for each type of connection based upon the specific environment as well as topic names in that environment.

# Notes for Production 
1. Production is not free, establishing a connection is a fee event with CME. Please check your fee schedule with CME for the expected costs.


# Links and Sources for reference 
(Terraform Docs for PubSub Subscriptions with Topic in Different Project)[https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription#example-usage---pubsub-subscription-different-project]

(Using Service Accounts in Terraform)[https://cloud.google.com/blog/topics/developers-practitioners/using-google-cloud-service-account-impersonation-your-terraform-code]

(CME Formats and Smart Stream Documentation)[https://www.cmegroup.com/confluence/display/EPICSANDBOX/CME+Smart+Stream+on+GCP]

