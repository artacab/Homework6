public class CreateTaskForAccount {
    @InvocableMethod
    public static void NewTask(List<Id> accountIds) 
    { 	
        List<Task> taskList = new List<Task>();
        List<Account> accs = [SELECT Name from Account WHERE Id in :accountIds];
        for(Account accfortask : accs) {
        	taskList.add(new Task(Subject='Negotiations with ' + accfortask.Name, WhatId = accfortask.Id));   
        }
        upsert taskList;
        List<Task> assignTask = [SELECT Id from Task WHERE WhatId =: accountIds];
        if(assignTask.size() >= 3) {
            Integer randomNumber = Integer.valueof((Math.random() * 10));
            User randomUser = [SELECT Id,Name FROM User LIMIT 1 OFFSET :randomNumber];
            for(Task task : assignTask) {
                task.OwnerId = randomUser.Id;
            }
        }
        update assignTask;
	} 
}