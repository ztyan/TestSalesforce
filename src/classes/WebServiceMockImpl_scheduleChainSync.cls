@isTest
global class WebServiceMockImpl_scheduleChainSync implements WebServiceMock {
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
       soapScheduleChainList.scheduleChainSyncResponse_element respElement = 
           new soapScheduleChainList.scheduleChainSyncResponse_element();
       response.put('response_x', respElement); 
   }
}