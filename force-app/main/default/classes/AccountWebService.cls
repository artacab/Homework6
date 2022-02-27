public with sharing class AccountWebService {
 
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 
    public class NewAccountRequestWrapper {
        public String name {get; set;}
        public String phone {get; set;}
    }
 
    public static HTTPResponse getAccount(Id accId) {
 
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:AccountsApi/services/apexrest/Account/' + accId);
        response = http.send(request); 
        System.debug(response.getBody());
        return response;
    }
    
    public static HTTPResponse addAccount(NewAccountRequestWrapper newAccount) {
 
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:AccountsApi/services/apexrest/Account/');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(newAccount));
 
        response = http.send(request); 
 
        System.debug(response.getBody());
        return response;
    }
 
    public static HTTPResponse deleteAccount(Id accId) {
 
        request = new HttpRequest();
        request.setMethod('DELETE');
        request.setEndpoint('callout:AccountsApi/services/apexrest/Account/' + accId);
        response = http.send(request); 
        System.debug(response.getBody());
        return response;
    }
    
    public static HTTPResponse createUpdateAccount(NewAccountRequestWrapper newAccount, String accId) {
 
        request = new HttpRequest();
        request.setMethod('PUT');
        request.setEndpoint('callout:AccountsApi/services/apexrest/Account/' + accId);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(newAccount));
        response = http.send(request); 
        System.debug(response.getBody());
        return response;
    }
    public static HTTPResponse updateAccount(NewAccountRequestWrapper newAccount, String accId) {
 
        request = new HttpRequest();
        request.setMethod('PATCH');
        request.setEndpoint('callout:AccountsApi/services/apexrest/Account/' + accId);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(newAccount));
        response = http.send(request); 
        System.debug(response.getBody());
        return response;
    }
}