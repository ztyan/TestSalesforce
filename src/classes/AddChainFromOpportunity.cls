public class AddChainFromOpportunity {
    
    /* Constructor Function. The Opportunity id is captured in this function */
    public AddChainFromOpportunity(ApexPages.StandardController controller)
    {
        cid=System.currentPageReference().getParameters().get('id');
    }
    
    /* Variable declarations */
    public static Integer ROWS_PER_PAGE = 30;
    public static String currentUser = UserInfo.getUserName();
    
    Public String cid;                                                         // Stroes Opportunity Id
    /* End of Variable declarations */
    
    
    /* Getter and setter methods for getting the user input ie. chain ID and chain Name from the UI */
    public List<ChainWrapper> chainList {get; set;}                             // Wrapper class which stores chain data and a boolean flag.
    public Boolean selectAllCheckbox {get; set;}                                // Stores checkbox data.
    Public String chainID{get;set;}                                             // chain id
    public String chainName{get;set;}                                           // chain name
    public Integer pageNum {get; set;}
    public Integer totalPageNum {get; set;}
    public Integer firstIndex {get; set;}
    public List<ChainWrapper> paginatedChainList {get; set;}
    public boolean errorMsg{get;set;}                                            // Error msg. When no chain has been selected.
    /*End of Getter and Setter methods */
    
    
    /* Search the chain database to fetch the query results */
    public List<Chain__c> chainSearch()
    {
         errorMsg=false;
         pageNum = 1;
         chainList = new List<ChainWrapper>();
         for(Chain__c c : [SELECT oci_chain_id__c,Name,isTemplate__c 
                           FROM Chain__c 
                           WHERE Id not in (select outcome1__ChainId__c from outcome1__OpportunityChain__c) 
                           and Name like :chainName+'%' 
                           and Chain_External_User__c = :currentUser])
         {
             chainList.add(new ChainWrapper(c));
         }
         totalPageNum=getTotalPages();     
         paginateList();
     return null;
    }
    
    /* Paginating */
    /* the chain list after pagination which would be passed to UI */
    public void paginateList(){    	
        paginatedChainList = new List<ChainWrapper>();
        firstIndex = ROWS_PER_PAGE * pageNum - ROWS_PER_PAGE ;
        for(Integer i=firstIndex; i<firstIndex+ROWS_PER_PAGE && chainList !=null && chainList.size() > i; i++){
           paginatedChainList.add(chainList.get(i));
        }
    }
    
    public void firstPage(){
        pageNum=1;
        paginateList();
    }
    
    public Boolean hasFirstPage{
        get {
            return getTotalPages()>0 && pageNum!=1;
        }
    }
    
    public void nextPage(){
        pageNum++;
        paginateList();
    }
    
    public Boolean hasNextPage{
        get {
            return pageNum<totalPageNum;
        }
    }
    
    public void previousPage(){
        pageNum--;
        paginateList();
    }
    
    public Boolean hasPreviousPage{
        get {
            return pageNum>1;
        }
    }
    
    public void lastPage(){
        pageNum=totalPageNum;
        paginateList();
    }
    
    public Boolean hasLastPage{
        get {
            return totalPageNum>0 && pageNum!=totalPageNum;
        }
    }
    
    
    public Integer getTotalPages(){
       if(chainList==null) chainList=new List<ChainWrapper>();
       if(chainList!=null && System.Math.mod(chainList.size(), ROWS_PER_PAGE ) == 0)
          return chainList.size() / ROWS_PER_PAGE ;
       else
          return (chainList.size() / ROWS_PER_PAGE ) + 1;
    }
    
    /* Paginating */
    
    
    /* Wrapper class to contain chain record and a boolean flag */
    public class ChainWrapper
    {
         public Chain__c chain {get; set;}
         public Boolean selected {get; set;}
        
         /*This is the contructor method. When we create a new ChainWrapper object we pass a
         Chain that is set to the cha property. We also set the selected value to false*/
         public ChainWrapper(Chain__c c)
         {
             chain = c;
             selected = false;
         }
    }
    /* end of Wrapper class */
    
    
    /* Method to fetch the selected records */
    public PageReference processSelected()
    {
    
      List<Chain__c> selectedChains = new List<Chain__c>();
      OpportunityChain__c[] chainOpps= new OpportunityChain__c[]{};
      if (chainList!= null)
      {
         for(ChainWrapper chainW : paginatedChainList){
            if(chainW.selected == true){
                 selectedChains.add(chainW.chain);
                 OpportunityChain__c chaOpp = new OpportunityChain__c(ChainId__c=chainW.chain.Id,OpportunityId__c=cid);
                 chainOpps.add(chaOpp);
             }
         }
         
         try {
             upsert chainOpps;
         } catch(DmlException e){
         
         }     
      }
     /* return error message if no chain is selected */
     if (selectedChains.size()==0)
     {
         errorMsg=true;
         return null;
     }
     else
     {
         errorMsg=false;
         return Cancel();
     }
    
    }
    
    /* Method to cancel the entire process */
    public Pagereference Cancel()
    {
            Pagereference p =new Pagereference('/'+cid);
            return p;
    }      
}