@isTest
public class AccountBatchableTest {
	@testSetup
    static void setup() {
        List<Task> tasks = new List<Task>();
        List<Account> accounts = new List<Account>();
        for (Integer i=0;i<50;i++) {
            accounts.add(new Account(Name='test account '+i));
        }
        insert accounts;
        for (Account a : accounts) {
            tasks.add(new Task(Subject='new task '+a.id, Is_Synced__c = false, WhatId = a.id));
        }
        insert tasks;
    }
    @isTest static void test() {
        Test.startTest();
        AccountBatchable ach = new AccountBatchable();
        Id batchId = Database.executeBatch(ach);
        Test.stopTest();
    }
}