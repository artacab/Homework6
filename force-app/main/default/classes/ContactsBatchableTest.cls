@isTest
public class ContactsBatchableTest {
	@testSetup
    static void setup() {
        List<Account> acs = new List<Account>();
        List<Contact> cts = new List<Contact>();
        Account tempAcc;
        for (Integer i = 0; i < 100; i++) {
            tempAcc = new Account(Name = 'test ac'+i, BillingCity='city'+i, BillingStreet='street'+i, BillingState='state'+i, BillingCountry='country'+i, BillingPostalCode='code'+i, Updated_By_Contact__c = false);
            acs.add(tempAcc);
        }
        insert acs;
        for(Account a : acs) {
            cts.add(new Contact(LastName='test con'+ a.Name, AccountId = a.Id, Is_Synced__c = false));
        }
        insert cts;
     
    }
    @isTest static void test() {
        Test.startTest();
        ContactsBatchable ach = new ContactsBatchable();
        Id batchId = Database.executeBatch(ach);
        Test.stopTest();
    }
}