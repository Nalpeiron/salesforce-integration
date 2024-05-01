
# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started

## Installation 
<a href="https://githubsfdeploy.herokuapp.com?owner=Nalpeiron&repo=salesforce-integration&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## Post Installation Configuration Steps

* Add the "Create Account In Zentitle" action to the account page layout. (Pro Tip: use dynamic actions on the lightning page to only show the action when the "Zentitle_Customer_ID__c" field is blank on the account.)
* Assign appropiate users the "Software_Entitlements_Admin" permission set
* Go in Salesforce Setup > Security > Named Credentials > Select the Named Credential named "Zentitle API", Click Edit.
  * Set the URL to be the "API URL" found in the API Credentials page of your Zentitle Account. (ie: https://sf-demo.api.zentitle.io), click Save
  * Under the Custom Headers section click edit to edit the "N-TenantId", replace the value with the "Tenant ID" found in the API Credentials page of your Zentitle Account. (ie: t_91a077j3fky5555812w ), click Save
  * Under the Authentication section of the Named Credential, Click on the External Credential named "Zentitle Api"
  * Click Edit to update the External Credential
  * Set the Identity Provider URL to be the "OAuth URL" value found in the API Credentials page of your Zentitle Account, appended by "/protocol/openid-connect/token" (ie: https://sf-demo.keycloak.zentitle.io/realms/sf-demo/protocol/openid-connect/token ), click Save
  * Under the Principles section click edit to add the auth the keys
  * In a new tab, go in the API Credentials page of your Zentitle Account and click "Add API Client", set a name of your choosing, click Save
  * Back in the Salesforce Principles edit screen enter the name you used for the "Client ID" and copy the client secret from Zentitle and enter that for the "Client Secret", click Save


## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
