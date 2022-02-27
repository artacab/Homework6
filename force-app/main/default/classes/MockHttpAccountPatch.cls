global class MockHttpAccountPatch implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest req) {
      System.assertEquals('callout:AccountsApi/services/apexrest/Account/0012y00000Lg7lQAAR', req.getEndpoint());
      System.assertEquals('PATCH', req.getMethod());
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      res.setBody('{"example":"test"}');
      res.setStatusCode(200);
      return res;
    }
}