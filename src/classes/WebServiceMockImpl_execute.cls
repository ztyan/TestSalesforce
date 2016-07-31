@isTest
global class WebServiceMockImpl_execute implements WebServiceMock {
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
       soapChainList.executeResponse_element  respElement = 
           new soapChainList.executeResponse_element();
       response.put('response_x', respElement); 
   }
}