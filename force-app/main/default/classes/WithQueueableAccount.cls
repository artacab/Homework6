public class WithQueueableAccount implements Queueable{
	private List<Account> acs;
    public WithQueueableAccount(List<Account> records) {
        this.acs = records;
    }
    public void execute(QueueableContext context) {
    	List<Contact> cts = new List<Contact>();
      		for(Account a : acs) {
         		if (String.isBlank(a.BillingCity) == false || String.isBlank(a.BillingStreet) == false || String.isBlank(a.BillingState) == false || String.isBlank(a.BillingCountry) == false || String.isBlank(a.BillingPostalCode) == false) {
             		for(Contact c : a.Contacts) {
                 		c.Is_Synced__c = false;
                 		c.Processed_By_Queue__c = true;
                 		cts.add(c);
             		}	      
         		}     
      		}
   	  		update cts;
   }
}