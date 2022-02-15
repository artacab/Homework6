global class ContactsBatchable implements Database.Batchable<Contact>, Iterable<Contact>, Iterator<Contact>{
    public integer i;
  	List<Contact> cts;
  	public ContactsBatchable() {
    	cts = [Select Id, AccountId from Contact Where Is_Synced__c = false];
    	i = 0;
  	}
  	
    public Iterator<Contact> iterator() {
    	return this;
  	}
  	
    public boolean hasNext() {
    	if(cts.size() <= i) return false;
    	else return true;
  	}
  	public Contact next() {
    	i++;
    	return cts[i-1];
  	}

    global Iterable<Contact> start(Database.BatchableContext bc) {
    	return new ContactsBatchable();
  	} 
  	
    global void execute(Database.BatchableContext bc, List<Contact> scope) {
    	for(Contact ct : scope) {
      		ct.MailingStreet = ct.Account.BillingStreet;
            ct.MailingCity = ct.Account.BillingCity;
            ct.MailingState = ct.Account.BillingState;
            ct.MailingPostalCode = ct.Account.BillingPostalCode;
            ct.Is_Synced__c = true;
            ct.Account.Updated_By_Contact__c = true;
    	}
    	
        update scope;
  	}
  	global void finish(Database.BatchableContext bc) {}
}