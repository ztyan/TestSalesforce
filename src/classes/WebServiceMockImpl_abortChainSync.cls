@isTest
global class WebServiceMockImpl_abortChainSync implements WebServiceMock {
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
       soapScheduleChainList.abortChainSyncResponse_element respElement = 
           new soapScheduleChainList.abortChainSyncResponse_element();
       response.put('response_x', respElement); 
   }
}