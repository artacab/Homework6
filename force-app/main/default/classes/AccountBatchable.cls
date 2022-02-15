public class AccountBatchable implements
    Database.Batchable<sObject>, Database.Stateful { 
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID, Owner FROM Task Where Is_Synced__c = false');
    }   
    public void execute(Database.BatchableContext bc, List<Task> scope){
        List<Task> tasksForUpd = new List<Task>();
        for (Task t : scope) {
        	t.Account_Owner__c = t.Owner.Name;
            t.Is_Synced__c = true;
            t.Account.Updated_By_Task__c = true;
            tasksForUpd.add(t);
        }
        update tasksForUpd;
    }
    public void finish(Database.BatchableContext bc){
    }
}