@ISTest
private class AccountRestApiTest {
	@isTest static void testGetAccount() {
        Account testAcc = new Account(Name='Michael', Phone='78945611');
        insert testAcc;
        Id recordId = testAcc.Id;
        RestRequest request = new RestRequest();
        request.requestUri ='services/apexrest/Accounts/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountRestApi.doGet();
        System.assert(thisAccount != null);
        System.assertEquals('78945611', thisAccount.Phone);
    }
    @isTest static void testCreateAccount() {
        Id recordId = AccountRestApi.doPost('Bunnie', '5986623', 'abop@ynd.ru');
        System.assert(recordId != null);
        Account thisAccount = [SELECT Id, Name, Phone FROM Account WHERE Id=:recordId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Name, 'Bunnie');
    }
    @isTest static void testDeleteAccount() {
        Account testAcc = new Account(Name='Michael', Phone='78945611');
        insert testAcc;
        Id recordId = testAcc.Id;
        RestRequest request = new RestRequest();
        request.requestUri ='services/apexrest/Accounts/'+ recordId;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        AccountRestApi.doDelete();
        List<Account> acs = [SELECT Id FROM Account WHERE Id=:recordId];
        System.assert(acs.size() == 0);
    }
    @isTest static void testPutAccount() {
        RestRequest request = new RestRequest();
        request.requestUri ='services/apexrest/Accounts/' + '';
        request.httpMethod = 'PUT';
        RestContext.request = request;
        Id recordId = AccountRestApi.doCreateUpdate('Lexio', '77413131', 'soaw@21f.com');
        Account acs = [SELECT Id, Phone FROM Account WHERE Id=:recordId];
        System.assert(recordId != null);
       	System.assertEquals(acs.Phone, '77413131');
        request.requestUri ='services/apexrest/Accounts/'+ acs.Id;
        request.httpMethod = 'PUT';
        RestContext.request = request;
        Id recordId2 = AccountRestApi.doCreateUpdate('Lexio', '8888888', 'soaw@21f.com');
        Account acs2 = [SELECT Id, Phone FROM Account WHERE Id=:recordId2];
        System.assert(recordId2 != null);
       	System.assertEquals(acs2.Phone, '8888888');
        System.assertEquals(acs2.Id, acs.Id);
        
    }
    @isTest static void testPatchAccount() {
        Account testAcc = new Account(Name='Michael', Phone='78945611');
        insert testAcc;
        Id recordId = testAcc.Id;
        RestRequest request = new RestRequest();
        request.requestUri ='services/apexrest/Accounts/'+ recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Name": "Sam"}');
        RestContext.request = request;
        Id acs = AccountRestApi.updateAccount();
        System.assert(acs != null);
        Account acs2 = [SELECT Id, Name, Phone FROM Account WHERE Id=:acs];
        System.assert(acs2 != null);
        System.assertEquals(acs2.Name, 'Sam');
    }
}