public class AccountBatchable implements
    Database.Batchable<sObject>, Database.Stateful { 
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID, OwnerId, WhatId, AccountId, Task.Account.Updated_By_Task__c FROM Task Where Is_Synced__c = false');
    }   
    public void execute(Database.BatchableContext bc, List<Task> scope){
        System.debug(scope);
        List<Task> tasksForUpd = new List<Task>();
        for (Task t : scope) {
        	t.Account_Owner__c = t.WhatId;
            t.Is_Synced__c = true;
            t.Account.Updated_By_Task__c = true;
            tasksForUpd.add(t);
        }
        update tasksForUpd;
    }
    public void finish(Database.BatchableContext bc){
    }
}