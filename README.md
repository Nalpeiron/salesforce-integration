
# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started

## Installation 
<a href="https://githubsfdeploy.herokuapp.com?owner=Nalpeiron&repo=salesforce-integration&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## Post Installation Configuration Steps

* Add the **Create Account In Zentitle** action to the Account page layout. (Pro Tip: use dynamic actions on the lightning page to only show the action when the **Zentitle_Customer_ID__c** field is blank on the account.)
* Assign appropiate users the **Software_Entitlements_Admin** permission set
* Go in **Salesforce Setup** > **Security** > **Named Credentials** > Select the Named Credential named **Zentitle API**, Click **Edit**.
  * Set the URL to be the **API URL** found in the *API Credentials* page of your Zentitle Account. (ie: `https://sf-demo.api.zentitle.io`), click Save
  * Under the *Custom Headers* section click **edit** to change the **N-TenantId**, replace the value with the **Tenant ID** found in the *API Credentials* page of your Zentitle Account. (ie: `t_91a077j3fky5555812w`), click **Save**
  * Under the *Authentication* section, Click on the External Credential named **Zentitle Api**
  * Click Edit to update the External Credential
  * Set the Identity Provider URL to be the **OAuth URL** value found in the API Credentials page of your Zentitle Account, appended by `/protocol/openid-connect/token` (ie: `https://sf-demo.keycloak.zentitle.io/realms/sf-demo/protocol/openid-connect/token`), click Save
  * Under the Principles section click edit to add the auth the keys
  * In a new tab, go in the API Credentials page of your Zentitle Account and click *Add API Client*, set a name of your choosing, click **Save**
  * Back in the Salesforce *Principles* edit screen enter the name you used for the **Client ID** and copy the client secret from Zentitle and enter that for the **Client Secret**, click **Save**

## Creating Your First Software Entitlement

* Create the demo app as outlined in this guide: [Creating a Product and Entitlement in the Zentitle UI for testing](https://docs.zentitle.io/developers/no-code-test-application/creating-a-product-and-entitlement/ "Named link title")
* Go to an Account in Salesforce
* Click the **Create Account In Zentitle** to create the Account in Zentitle
* Search for *Software Entitlements* in the waffle (app launcher in top left)
* Click the *New* button to make a new entitlement, set the *Entitlement Type* as **Single**, set the *Offering* to be the offering code (ie: Std-1001), set the *Entitlement Seat Count* to be the number of seats for the license, set the *Account* as the account you just sent to Zentitle, click **Save**
* Wait ***1-2 mins*** for the provisioning to happen then refresh the page, you should see the record with all of the information populated.
* All syncs to and from Zentitle, whether successfull or unsuccessfull, are logged as a task on the *Software Entitlement* record, you can view these under the **Integration Log** tab.
