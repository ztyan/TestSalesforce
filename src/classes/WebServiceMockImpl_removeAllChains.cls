@isTest
global class WebServiceMockImpl_removeAllChains implements WebServiceMock {
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
       soapChainList.removeAllChainsResponse_element  respElement = 
           new soapChainList.removeAllChainsResponse_element();
       response.put('response_x', respElement); 
   }
}