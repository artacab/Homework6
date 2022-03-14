public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodoList() {
        return [
            SELECT
                Name,
                Title__c,
                Category__c
            FROM Todo__c
        ];
    }
}
