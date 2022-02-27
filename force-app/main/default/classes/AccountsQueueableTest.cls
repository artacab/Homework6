@ISTest
public class AccountsQueueableTest {
	@testSetup
    static void setup() {
        List<Contact> cts = new List<Contact>();
        for (Integer i = 0; i < 100; i++) {
            cts.add(new Contact(LastName='Test con'+i, Is_Synced__c = true, Processed_By_Queue__c = false));
        }
        insert cts;
    }
    static testmethod void testQueueable() {
        List<Contact> contacts = [select id, LastName from contact where LastName like 'Test con%'];
   		System.debug(contacts);
        AccountsQueueable updater = new AccountsQueueable(contacts);
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        System.assertEquals(100, [select count() from contact where LastName like 'Test con%']);
    }
}