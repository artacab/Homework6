@ISTest
public class CreateTaskForAccountTest {
	@isTest static void test() {
        List<Account> acs = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            acs.add(new Account(Name='Test acc'+i));
        }
        insert acs;
        Map<Id, Account> acMap = new Map<Id, Account>(acs);
        List<Id> accIds = new List<Id>(acMap.keySet());
        Test.startTest();
        CreateTaskForAccount.NewTask(accIds);
        Test.stopTest();
        System.assertEquals(100, [select count() from task where Subject like 'Negotiations with%']);
    }
}