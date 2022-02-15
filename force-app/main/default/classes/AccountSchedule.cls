public class AccountSchedule implements Schedulable{
	public void execute(SchedulableContext ctx) {
        AccountBatchable a = new AccountBatchable();
        database.executeBatch(a);
        ContactsBatchable b = new ContactsBatchable();
        database.executeBatch(b);
    }
}