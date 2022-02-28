@ISTest
public class WithoutTriggerFutureTest {
    @testSetup
    static void setup() {
        List<Account> acs = new List<Account>();
        List<Contact> cts = new List<Contact>();
        Account tempAcc;
        for (Integer i = 0; i < 150; i++) {
            tempAcc = new Account(Name = 'test ac'+i, BillingCity='city'+i, BillingStreet='street'+i, BillingState='state'+i, BillingCountry='country'+i, BillingPostalCode='code'+i);
            acs.add(tempAcc);
        }
        insert acs;
        for(Account a : acs) {
            cts.add(new Contact(LastName='test con'+ a.Name, AccountId = a.Id, Is_Synced__c = true, Processed_By_Future__c = false));
        }
        insert cts;
    }
    static testmethod void testFuture() {
        Test.startTest();
        WithoutTriggerFuture.updateSync();
        Test.stopTest();
    }
}