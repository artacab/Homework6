@isTest
public class AccountScheduleTest {
	public static String CRON_EXP = '0 30 * * * ?';
    static testmethod void testScheduledJob() {
        Test.startTest();
        String jobId = System.schedule('ScheduleTest',CRON_EXP,new AccountSchedule());
        Test.stopTest();
    }
}