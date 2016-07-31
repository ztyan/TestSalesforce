@isTest
global class WebServiceMockImpl_getAllChains implements WebServiceMock {
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
       soapChainList.getAllChainsResponse_element respElement = 
           new soapChainList.getAllChainsResponse_element();
       response.put('response_x', respElement); 
   }
}