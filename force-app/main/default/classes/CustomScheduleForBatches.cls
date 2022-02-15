public class CustomScheduleForBatches implements Schedulable{
	public void execute(SchedulableContext ctx) {
        CustomBatch1 a = new CustomBatch1();
        database.executeBatch(a);
        CustomBatch2 b = new CustomBatch2();
        database.executeBatch(b);
    }
}