@isTest
global class WebServiceMockImpl_existChainSync implements WebServiceMock {
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
       soapScheduleChainList.existChainSyncResponse_element respElement = 
           new soapScheduleChainList.existChainSyncResponse_element();
       response.put('response_x', respElement); 
   }
}