public class WithoutTriggerFuture {
	@future
    public static void updateSync() {
    List<Contact> cts = new List<Contact>();
  	List<Account> acs = [Select Id, BillingCity, BillingStreet, BillingState, BillingCountry, BillingPostalCode, (Select Id from Contacts) from Account LIMIT 150];
      for(Account a : acs) {
         if (String.isBlank(a.BillingCity) == false || String.isBlank(a.BillingStreet) == false || String.isBlank(a.BillingState) == false || String.isBlank(a.BillingCountry) == false || String.isBlank(a.BillingPostalCode) == false) {
             for(Contact c : a.Contacts) {
                 c.Is_Synced__c = false;
                 c.Processed_By_Future__c = true;
                 cts.add(c);
             }	      
         }     
      }
   	  update cts;
  }
}