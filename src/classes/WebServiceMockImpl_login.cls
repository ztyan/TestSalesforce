@isTest
global class WebServiceMockImpl_login implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
       soapChainList.loginResponse_element  respElement = 
           new soapChainList.loginResponse_element();
       response.put('response_x', respElement); 
   }
}