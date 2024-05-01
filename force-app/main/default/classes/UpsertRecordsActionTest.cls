/**
 * Description: This repo contains an Apex Invocable Action that provides the ability to Upsert Records in Lightning Flow from Salesforce.
 * https://github.com/ryanfollmer/UpsertRecordsFlowAction/blob/master/force-app/main/default/classes/UpsertRecordsActionTest.cls
 */

@IsTest
public class UpsertRecordsActionTest {
    
    @IsTest
    private static void testDefaultBehavior(){
        
// Create an Account to link with Software_Entitlement
        Account testAccount = new Account(
            Name = 'Test Account',
            Zentitle_Customer_ID__c = 'Test'
        );
        insert testAccount;
        
        
        List<UpsertRecordsAction.UpsertRequest> requests = new List<UpsertRecordsAction.UpsertRequest>();

        UpsertRecordsAction.UpsertRequest entmnts = new UpsertRecordsAction.UpsertRequest();

        List<Software_Entitlement__c> softwareEntitlements = new List<Software_Entitlement__c>();

        softwareEntitlements.add(new Software_Entitlement__c(
            Account__c = testAccount.Id,
            Entitlement_Type__c = 'Single',
            Offering__c = 'TEST',
            Entitlement_Seat_Count__c = 2
        ));
        softwareEntitlements.add(new Software_Entitlement__c(
            Account__c = testAccount.Id,
            Entitlement_Type__c = 'Single',
            Offering__c = 'TEST',
            Entitlement_Seat_Count__c = 2
        ));

        entmnts.records = softwareEntitlements;
        requests.add(entmnts);

        
// Create a Software Entitlement record linked to the newly created Account
        Software_Entitlement__c se = new Software_Entitlement__c(
            Account__c = testAccount.Id,
            Entitlement_Type__c = 'Single',
            Offering__c = 'TEST',
            Entitlement_Seat_Count__c = 2
        );
        
        
        
        List<UpsertRecordsAction.UpsertResult> results = UpsertRecordsAction.upsertRecords(requests);

        System.assert(results != null, 'Upsert Results should not be null.');
        System.assertEquals(2, results[0].results.size(), 'Result collection should contain 2 items.');
    }

    @IsTest
    private static void testUpsertUsingExternalIdKey(){
        
// Create an Account to link with Software_Entitlement
        Account testAccount = new Account(
            Name = 'Test Account',
            Zentitle_Customer_ID__c = 'Test'
        );
        insert testAccount;
        
     Software_Entitlement__c testSoftwareEntitlement = new Software_Entitlement__c(
            Account__c = testAccount.Id,
            Entitlement_Type__c = 'Single',
            Offering__c = 'TEST',
            Entitlement_Seat_Count__c = 2
        );


        List<UpsertRecordsAction.UpsertRequest> requests = new List<UpsertRecordsAction.UpsertRequest>();

        UpsertRecordsAction.UpsertRequest entmnts = new UpsertRecordsAction.UpsertRequest();

                
        List<Software_Entitlement__c> softwareEntitlements = new List<Software_Entitlement__c>();
		// Add existing single we already created
        softwareEntitlements.add(testSoftwareEntitlement);
        // Create new software entitlement to add
        softwareEntitlements.add(new Software_Entitlement__c(
            Account__c = testAccount.Id,
            Entitlement_Type__c = 'Single',
            Offering__c = 'TEST',
            Entitlement_Seat_Count__c = 2
        ));
        
        entmnts.records = softwareEntitlements;
        
        
        // Custom text field on Account object - flagged as External ID 
        entmnts.externalIDField = 'Zentitle_Attribute_ID__c';

        requests.add(entmnts);

        List<UpsertRecordsAction.UpsertResult> results = UpsertRecordsAction.upsertRecords(requests);

        System.assert(results != null, 'Upsert Results should not be null.');
        System.assertEquals(2, results[0].results.size(), 'Result collection should contain 2 items.');

    }
}