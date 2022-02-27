global class MockHttpAccountAdd implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
      System.assertEquals('callout:AccountsApi/services/apexrest/Account/', req.getEndpoint());
      System.assertEquals('POST', req.getMethod());
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      res.setBody('{"example":"test"}');
      res.setStatusCode(200);
      return res;
    }
}