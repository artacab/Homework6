@isTest
public class TestCreateTask {
    @isTest static void test() {
        List<Task> tasks = new List<Task>();
        for (Integer i=0;i<50;i++) {
            tasks.add(new Task(Subject='new task '+i));
        }
        insert tasks;
    }
}