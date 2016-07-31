public class WebSvcCallout {
    public static void callGetAllChains() {
        soapChainList.chainList sample = new soapChainList.chainList ();
        // This invokes the EchoString method in the generated class
        sample.getAllChains();
    }  
    
    public static void callRemoveAllChains() {
        soapChainList.chainList sample = new soapChainList.chainList ();
        //sample.endpoint_x = 'https://na30.salesforce.com/services/Soap/class/chainList';
        
        // This invokes the EchoString method in the generated class
        sample.removeAllChains();
    }     
    
    public static void callScheduleChainSync() {
        soapScheduleChainList.scheduleChainList sample = new soapScheduleChainList.scheduleChainList ();
        //sample.endpoint_x = 'https://na30.salesforce.com/services/Soap/class/scheduleChainList';
        
        // This invokes the EchoString method in the generated class
        sample.scheduleChainSync();
    }   
    
    public static void callAbortChainSync() {
        soapScheduleChainList.abortChainSync sample = new soapScheduleChainList.abortChainSync();
        //sample.endpoint_x = 'https://na30.salesforce.com/services/Soap/class/scheduleChainList';
        
        // This invokes the EchoString method in the generated class
        sample.abortChainSync();
    } 
    
    public static void callExistChainSync() {
        soapScheduleChainList.existChainSync sample = new soapScheduleChainList.existChainSync();
        //sample.endpoint_x = 'https://na30.salesforce.com/services/Soap/class/scheduleChainList';
        
        // This invokes the EchoString method in the generated class
        sample.existChainSync();
    }          
    
    public static void callExecute() {
        soapChainList.chainList sample = new soapChainList.chainList ();
        //sample.endpoint_x = 'https://na30.salesforce.com/services/Soap/class/chainList';
        
        // This invokes the EchoString method in the generated class
        SchedulableContext ctx = null;
        sample.execute(ctx);
    }  
    
    public static void callLogin() {
        soapChainList.chainList sample = new soapChainList.chainList ();
        //sample.endpoint_x = 'https://na30.salesforce.com/services/Soap/class/chainList';
      
        sample.login();
    }  
    
    public static void callGetParser(String endPoint) {
        soapChainList.chainList sample = new soapChainList.chainList ();
        //sample.endpoint_x = 'https://na30.salesforce.com/services/Soap/class/chainList';
      
        sample.getParser(endPoint);
    }                    
}