public class AccountTriggerHandler {
  @future
  public static void updateSync(List<Id> recordIds) {
  	List<Task> tasks = [Select Id from Task Where Id IN :recordIds];
      for(Task t : tasks) {
		t.Is_Synced__c = false;     
      }
    update tasks; 
  }
  @future
  public static void updateContactSync(Set<Id> recordIds) {
  	List<Contact> listContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :recordIds];
      for(Contact ct : listContacts) {
		ct.Is_Synced__c = false;
        ct.Processed_By_Future__c = true;
      }
      update listContacts;
  }
    public static void updateWithQueueable(Set<Id> recordIds) {
        List<Contact> listContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :recordIds];
        System.debug(recordIds);
  		AccountsQueueable newJob = new AccountsQueueable(listContacts);
        ID jobID = System.enqueueJob(newJob);
    }
}