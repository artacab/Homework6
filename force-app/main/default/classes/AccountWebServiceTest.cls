@ISTest
private class AccountWebServiceTest {
    public class NewAccountRequestWrapper {
        public String name {get; set;}
        public String phone {get; set;}
    }
    @isTest static void testCallout() { 
    	Test.setMock(HttpCalloutMock.class, new MockHttpAccount()); 
        HttpResponse res = AccountWebService.getAccount('0012y00000Lg7lQAAR');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"example":"test"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
    @isTest static void testCalloutDelete() { 
        Test.setMock(HttpCalloutMock.class, new MockHttpAccountDelete()); 
        HttpResponse res = AccountWebService.deleteAccount('0012y00000Lg7lQAAR');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"example":"test"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
    @isTest static void testCalloutAdd() { 
        Test.setMock(HttpCalloutMock.class, new MockHttpAccountAdd());
        HttpResponse res = AccountWebService.addAccount(new AccountWebService.NewAccountRequestWrapper());
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"example":"test"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
    @isTest static void testCalloutPut() { 
        Test.setMock(HttpCalloutMock.class, new MockHttpAccountPut());
        HttpResponse res = AccountWebService.createUpdateAccount(new AccountWebService.NewAccountRequestWrapper(), '0012y00000Lg7lQAAR');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"example":"test"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
    @isTest static void testCalloutPatch() { 
        Test.setMock(HttpCalloutMock.class, new MockHttpAccountPatch());
        HttpResponse res = AccountWebService.updateAccount(new AccountWebService.NewAccountRequestWrapper(), '0012y00000Lg7lQAAR');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"example":"test"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
}