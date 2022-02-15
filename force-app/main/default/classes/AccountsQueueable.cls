public class AccountsQueueable implements Queueable{
	private List<Contact> cts;
    public AccountsQueueable(List<Contact> records) {
        this.cts = records;
    }
    //System.debug(accounts);
    public void execute(QueueableContext context) {
        System.debug(cts);
        for (Contact ct : cts) {
            //System.debug(ct);
            ct.Is_Synced__c = false;
        	ct.Processed_By_Queue__c = true;
        }
        update cts;
    }
}