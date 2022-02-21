@RestResource(urlMapping='/Account/*')
global with sharing class AccountRestApi {
	@HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
    
    @HttpPut
    global static String doCreateUpdate(String name, String phone, String website, String acid) {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = new Account();
        if(String.isNotEmpty(accountId)) {
            account.Id = accountId;
        }
        account.Name = name;
        account.Phone = phone;
        account.Website = website;
        upsert account;
        return account.Id;
    }
    
    @HTTPPatch
    global static Account updateAccount() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        String requestBody = req.requestBody.toString();
        Account account;
        if(String.isNotEmpty(accountId)) {
            account = (Account) JSON.deserialize(requestBody, Account.class);
            account.Id = accountId;
            update account;
        }
        return account;
    }
    
 	
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
 
    @HttpPost
    global static String doPost(String name, String phone, String website) {
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;
    }
}