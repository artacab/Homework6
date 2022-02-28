@isTest
public class TestAccountUpdAdress {
    @isTest static void test() {
        List<Account> acs = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            acs.add(new Account(Name='Test acc'+i, BillingCity = 'city'+i, BillingStreet = 'street'+i, BillingCountry = 'country'+i, BillingPostalCode = 'postalCode'+i, BillingState = 'state'+i));
        }
        insert acs;
        for (Account a : acs) {
            a.Name = 'test'+a.id;
            a.BillingCity = 'city'+a.id;
        }
        Test.startTest();
        Database.SaveResult[] SR = Database.update(acs);
        Test.stopTest();
    }
}