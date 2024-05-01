
# Salesforce - Zentitle Integration: Next Steps

## Installation 
<a href="https://githubsfdeploy.herokuapp.com?owner=Nalpeiron&repo=salesforce-integration&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## Post-Installation Configuration Steps

* Add the **Create Account In Zentitle** action to the Account page layout. (Pro Tip: use dynamic actions on the lightning page to only show the action when the **Zentitle_Customer_ID__c** field is blank on the Account.)
* Assign appropriate users the **Software_Entitlements_Admin** permission set
* **IF THIS IS A SANDBOX** go to **Salesforce Setup** > **Custom Labels** > select the label named **Zentitle_Sandbox_Override** and click **Edit**, change the *Value* to `TRUE`, click **Save**
* Go to **Salesforce Setup** > **Security** > **Named Credentials** > Select the Named Credential named **Zentitle API**, and click **Edit**
  * Set the URL to be the **API URL** found in the *API Credentials* page of your Zentitle Account. (i.e., `https://sf-demo.api.zentitle.io`), click Save
  * Under the *Custom Headers* section click **Edit** to change the **N-TenantId**, and replace the value with the **Tenant ID** found in the *API Credentials* page of your Zentitle Account. (i.e., `t_91a077j3fky5555812w`), click **Save**
  * Under the *Authentication* section, click on the External Credential named **Zentitle Api**
  * Click Edit to update the External Credential
  * Set the Identity Provider URL to be the **OAuth URL** value found on the API Credentials page of your Zentitle Account, appended by `/protocol/openid-connect/token` (i.e., `https://sf-demo.keycloak.zentitle.io/realms/sf-demo/protocol/openid-connect/token`), click Save
  * Under the Principles section, click **Edit** to add the auth key
  * In a new tab, go to the API Credentials page of your Zentitle Account and click *Add API Client*, set a name of your choosing, click **Save**
  * Back in the Salesforce *Principles* edit screen, enter the name you used for the **Client ID**, copy the client secret from Zentitle, and enter that for the **Client Secret**, click **Save**

## Creating Your First Software Entitlement

* Create the demo app as outlined in this guide: [Creating a Product and Entitlement in the Zentitle UI for testing](https://docs.zentitle.io/developers/no-code-test-application/creating-a-product-and-entitlement/ "Named link title")
* Go to an Account in Salesforce
* Click the **Create Account In Zentitle** to create the Account in Zentitle
* Search for *Software Entitlements* in the waffle (app launcher in the top left)
* Click the *New* button to make a new entitlement, set the *Entitlement Type* as **Single**, set the *Offering* to be the offering code (i.e., `Std-1001`), set the *Entitlement Seat Count* to be the number of seats for the license, set the *Account* as the Account you just sent to Zentitle, click **Save**
* Wait ***1-2 minutes*** for provisioning, then refresh the page; you should see the record with all the information populated.
* All syncs to and from Zentitle, successful or unsuccessful, are logged as a task on the *Software Entitlement* record; you can view these under the **Integration Log** tab.


## Important Sandbox Refresh Note
* This solution usese a custom label named **Zentitle_Sandbox_Override**, it can be set to `TRUE` or `FALSE`. The value of the label in production has no impact, **HOWEVER** to ensure sandboxes don't erroneously send API calls, the production label should **ALWAYS** be set to `FALSE` so any sandbox that is refreshed is created as `FALSE`. Then in a sandbox, when needed, you can set the custom label to `TRUE` to allow outbound API calls to Zentitle for testing.
