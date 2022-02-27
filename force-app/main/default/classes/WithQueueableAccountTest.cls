@ISTest
public class WithQueueableAccountTest {
	@testSetup
    static void setup() {
        List<Account> acs = new List<Account>();
        List<Contact> cts = new List<Contact>();
        Account tempAcc;
        for (Integer i = 0; i < 100; i++) {
            tempAcc = new Account(Name = 'test ac'+i, BillingCity='city'+i, BillingStreet='street'+i, BillingState='state'+i, BillingCountry='country'+i, BillingPostalCode='code'+i);
            acs.add(tempAcc);
        }
        insert acs;
        for(Account a : acs) {
            cts.add(new Contact(LastName='test con'+ a.Name, AccountId = a.Id, Is_Synced__c = true, Processed_By_Queue__c = false));
        }
        insert cts;
     
    }
    static testmethod void testQueueable() {
        List<Account> accounts = [select id, Name, BillingCity, BillingStreet, BillingState, BillingCountry, BillingPostalCode, (Select LastName from contacts where Is_Synced__c = true and Processed_By_Queue__c = false)  from Account where Name like 'test ac%'];
        WithQueueableAccount updater = new WithQueueableAccount(accounts);
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        System.assertEquals(100, [select count() from contact where LastName like 'test con%' and Processed_By_Queue__c = true]);
    }
}