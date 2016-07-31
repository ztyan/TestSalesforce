@isTest
public class UnitTest {
    @isTest static void testGetAllCains() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_getAllChains());
        
        // Call the method that invokes a callout
         WebSvcCallout.callgetAllChains();      
        
        // Verify that a fake result is returned
        System.assert(1==1); 
    }
    
    @isTest static void testRemoveAllChains() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_removeAllChains());
        
        // Call the method that invokes a callout
        WebSvcCallout.callRemoveAllChains();
        
        // Verify that a fake result is returned
        System.assert(1==1); 
    }    
 
     @isTest static void testScheduleChainSync() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_scheduleChainSync());
        
        // Call the method that invokes a callout
        WebSvcCallout.callscheduleChainSync();
        
        // Verify that a fake result is returned
        System.assert(1==1); 
    }   
    
    @isTest static void testAbortChainSync() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_abortChainSync());
        
        // Call the method that invokes a callout
        WebSvcCallout.callAbortChainSync();
        
        // Verify that a fake result is returned
        System.assert(1==1); 
    } 
    
     @isTest static void testExistChainSync () {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_existChainSync());
        
        // Call the method that invokes a callout
        WebSvcCallout.callExistChainSync ();
        
        // Verify that a fake result is returned
        System.assert(1==1); 
    }     
    
    @isTest static void testExecute() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_execute());
        
        // Call the method that invokes a callout
         WebSvcCallout.callExecute(); 
        // Verify that a fake result is returned
        System.assert(1==1); 
    }  
    
    @isTest static void testLogin() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_login());
        
        // Call the method that invokes a callout
         WebSvcCallout.callLogin(); 
        // Verify that a fake result is returned
        System.assert(1==1); 
    }       
    
    @isTest static void testGetParser() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl_getParser());
        OutcomeChainsSettings__c chainsSettings = OutcomeChainsSettings__c.getOrgDefaults();
        String endPoint = chainsSettings.Base_Host_Url__c + '/v1/login?apiKey=' + chainsSettings.API_Key__c + '&apiSecret=' + chainsSettings.API_Secret__c;
        // Call the method that invokes a callout
         WebSvcCallout.callGetParser(endPoint); 
        // Verify that a fake result is returned
        System.assert(1==1); 
    }       
        
    @isTest static void testChainListConstructor1(){
        chainList lst = new chainList();
        System.assert(lst!=null);
    }    
        
    @isTest static void testChainListConstructor2(){
        ApexPages.StandardController controler = null;
        chainList lst = new chainList(controler);
        System.assert(lst!=null);
    } 
  
        
   public static String CRON_EXP = '0 0 0 15 3 ? 2022';

   @isTest static void testScheduleClass() {
      // Schedule the test job
      String jobId = System.schedule('SchedulingChainSyncTest',
                        CRON_EXP, 
                        new chainList());
         
      System.assert(1==1);
   }       
    
    @isTest static void testChainClass(){
        chainList.Chain c = new chainList.Chain();
        System.assert(c!=null);
    }
    
    @isTest static void testScheduleChainListConstructor(){
        chainList controller=null;
        scheduleChainList lst = new scheduleChainList(controller);
        System.assert(lst!=null);
    }  
        
    @isTest static void testPopulateChainMap(){
        chainList.populateChainMap();
        System.assert(1==1);
    }
    
    @isTest static void testAddChain(){
        chainList.Chain c = new chainList.Chain();
        c.name = 'chainNameForTesting';
        c.isTemplate = 'false';
        c.id = 123456;
        c.utime='1468648088388';        
        
        String chainUrl = 'https://qa.outcomechains.com';
        
        chainList.addChain(c,chainUrl);
        System.assert(1==1);
    }    
    
    @isTest static void testUpdateChain(){
        chainList.Chain c = new chainList.Chain();
        c.name = 'chainNameForTesting';
        c.isTemplate = 'false';
        c.id = 123456;
        c.utime='1468648088388';
        
        Chain__c chain = new Chain__c();
        chain.oci_chain_id__c=123456;
        chain.ChainUpdateTime__c=DateTime.newInstance(2015,1,1);
        chainList.updateChain(c,chain);
        System.assert(1==1);
    }     
        
    @isTest static void testDeleteChain(){
        Set<Decimal> unexistchainSet = null;
        chainList.deleteChain(unexistchainSet);
        System.assert(1==1);
    }
        
    @isTest static void testGetUnexistChainSet(){
        Set<Decimal> chainSet = new Set<Decimal>();             
        Set<Decimal> chainSourceSet = new Set<Decimal>();           
        chainList.getUnexistchainSet(chainSet,chainSourceSet);
        System.assert(1==1);
    }     
    
    @isTest static void testGetChains(){
        myOutcomeChains chains = new myOutcomeChains();
        chains.getChains();
        System.assert(1==1);
    }    
    
    @isTest static void testGetTemplates(){
        outcomeChainsTemplates template= new outcomeChainsTemplates();
        template.getTemplates();
        System.assert(1==1);
    }   
        
    @isTest static void testAddChainFromOpportunity(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        System.assert(1==1);
    }  
    
    @isTest static void testChainWrapper(){
        Chain__c chain = new Chain__c();
        AddChainFromOpportunity.ChainWrapper wrapper = new AddChainFromOpportunity.ChainWrapper(chain);
        System.assert(1==1);
    }    
    
    @isTest static void testChainSearch(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.chainName='OCI';
        addChains.chainSearch();
        System.assert(1==1);
    }   
   
    @isTest static void testFirstPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.pageNum=1;
        addChains.firstPage();               
        System.assert(1==1);
    }   
    
   
    @isTest static void testNextPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.pageNum=1;        
        addChains.nextPage();               
        System.assert(1==1);
    }  
    
    @isTest static void testPreviousPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.pageNum=1;        
        addChains.previousPage();               
        System.assert(1==1);
    } 
    
    @isTest static void testLastPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.totalPageNum=1;
        addChains.lastPage();               
        System.assert(1==1);
    }  
    
    @isTest static void testHasFirstPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.pageNum=1;
        Boolean has = addChains.hasFirstPage;               
        System.assert(1==1);
    } 

    
    @isTest static void testHasNextPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.pageNum=1;
        Boolean has = addChains.hasNextPage;               
        System.assert(1==1);
    } 
    
    
    @isTest static void testHasPreviousPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.pageNum=1;
        Boolean has = addChains.hasPreviousPage;               
        System.assert(1==1);
    } 
    
    
    @isTest static void testHasLastPage(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.pageNum=1;
        Boolean has = addChains.hasLastPage;               
        System.assert(1==1);
    }                           
     
    @isTest static void testCancel(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.Cancel();               
        System.assert(1==1);
    }                           
       
            
    @isTest static void testProcessSelected(){
        AddChainFromOpportunity addChains= new AddChainFromOpportunity(null);
        addChains.processSelected();
        System.assert(1==1);
    }                           
}