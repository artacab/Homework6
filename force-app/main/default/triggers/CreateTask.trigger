trigger CreateTask on Task (after insert) {
	List<ID> taskIds = new List<ID>();
    for(Task t : Trigger.new) {
        taskIds.add(t.Id);
    }
  	AccountTriggerHandler.updateSync(taskIds); 
}