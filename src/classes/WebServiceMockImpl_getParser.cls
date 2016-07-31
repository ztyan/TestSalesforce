@isTest
global class WebServiceMockImpl_getParser implements WebServiceMock {
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
       soapChainList.getParserResponse_element  respElement = 
           new soapChainList.getParserResponse_element();
       response.put('response_x', respElement); 
   }
}