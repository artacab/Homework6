public class CustomBatch2 implements
    Database.Batchable<sObject>, Database.Stateful{
	public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id, AccountId from Contact Where Is_Synced__c = false');
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> scope){
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
    public void finish(Database.BatchableContext bc){
    }
}