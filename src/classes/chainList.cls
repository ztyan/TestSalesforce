global class chainList implements Schedulable {

  public chainList(ApexPages.StandardController controller) {
  }
  
  public chainList(){
  }
    
  //schedule   
  global void execute(SchedulableContext ctx) {      
     getAllChains();
  } 
   
  //remove all chains  
  webService static void removeAllChains() {
       delete [select Name from Chain__c];
       //testAddDummyChains();       
   }
   
  //login via rest api 
  webService static String login() {
      OutcomeChainsSettings__c chainsSettings = OutcomeChainsSettings__c.getOrgDefaults();
  
      JSONParser parser = getParser(chainsSettings.Base_Host_Url__c + '/v1/login?apiKey=' + chainsSettings.API_Key__c + '&apiSecret=' + chainsSettings.API_Secret__c);
      while (parser.nextToken() != null) {
        if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
        { 
            if(parser.getText() == 'result') {
                // Get the value.
                parser.nextToken();
                system.debug('xxxxxxxxx----login status:'+parser.getText());
                return parser.getText();
            }
        }
      }    
      return '';        
} 

  //get parser of response
  webService static JSONParser getParser(String endPoint){
      Http http = new Http(); 
      HttpRequest req = new HttpRequest(); 
      req.setMethod('GET');
      req.setEndpoint(endpoint);  
      HttpResponse res = http.send(req);
      system.debug('xxxxxxxxx----endpoint:'+endPoint+'-------------'+res.getBody());      
      return JSON.createParser(res.getBody());
  }
  
  //get existed chain in salesforce
  public static Map<Decimal,Chain__c> populateChainMap(){
     Map<Decimal,Chain__c> chainMap = new Map<Decimal,Chain__c>(); 
     for(Chain__c c :[select Id,ChainURL__c,oci_chain_id__c,ChainUpdateTime__c from Chain__c]){
          chainMap.put(c.oci_chain_id__c,c);
      }
      return chainMap;      
  } 
  
  //add chain
  public static Chain__c addChain(Chain c,String chainUrl){
      if(c.id == NULL) return null;
      Chain__c chainObj = new Chain__c();
      chainObj.ChainURL__c=chainUrl+String.valueOf(c.id);
      chainObj.Description__c=c.name;
      chainObj.oci_chain_id__c=c.id;
      chainObj.Name=c.name;
      chainObj.isTemplate__c=Boolean.valueOf(c.isTemplate);    
      chainObj.Chain_Owner__c=c.chainOwnerUserName;
      chainObj.Chain_External_User__c=c.chainOwnerExternalUserName; 
      chainObj.ChainUpdateTime__c =DateTime.newInstance(long.valueOf(c.utime));
      system.debug('xxxxxxxxx----oc utime2'+chainObj.ChainUpdateTime__c.getTime());
      //system.debug('xxxxxxxxx----chain update time:'+c.utime+'---------------'+DateTime.newInstance(long.valueOf(c.utime)* 1000)+'--------'+DateTime.newInstance(long.valueOf(c.utime)));
      return chainObj;        
  } 
  
  //update chain
  public static Chain__c updateChain(Chain c,Chain__c chain){
      Chain__c chainObj = new Chain__c();
      DateTime sfUpdateTime = chain.ChainUpdateTime__c;
      sfUpdateTime = DateTime.newInstance(sfUpdateTime.year(),sfUpdateTime.month(),sfUpdateTime.day(),sfUpdateTime.hour(),sfUpdateTime.minute(),sfUpdateTime.second());      
      DateTime ocUpdateTime =DateTime.newInstance(long.valueOf(c.utime));
      ocUpdateTime = DateTime.newInstance(ocUpdateTime.year(),ocUpdateTime.month(),ocUpdateTime.day(),ocUpdateTime.hour(),ocUpdateTime.minute(),ocUpdateTime.second());            
      system.debug('xxxxxxxxx----oc utime1'+ocUpdateTime.getTime());
      //system.debug('xxxxxxxxx----salesforce utime'+sfUpdateTime.getTime());     
      
      if(sfUpdateTime <ocUpdateTime){
          //system.debug('xxxxxxxxx----enter update');
          chainObj = chain;
          chainObj.Description__c=c.name;
          chainObj.Name=c.name;
          chainObj.isTemplate__c=Boolean.valueOf(c.isTemplate);    
          chainObj.Chain_Owner__c=c.chainOwnerUserName;
          chainObj.Chain_External_User__c=c.chainOwnerExternalUserName; 
          chainObj.ChainUpdateTime__c =DateTime.newInstance(long.valueOf(c.utime));
          return chainObj;            
      }
      return null;    
  }       
  
  //get chains unexisting in oci app
  public static Set<Decimal> getUnexistchainSet(Set<Decimal> chainSet,Set<Decimal> chainSourceSet){
     Set<Decimal> unexistchainSet = new Set<Decimal>();
     for(Decimal id : chainSet){
        if(chainSourceSet.contains(id)==false){
            //system.debug('xxxxxxxxx----unexist chain id:'+id);
            unexistchainSet.add(id);
        }
     }
     return unexistchainSet;   
  }    
  
  //delete chains unexisting in oci app,as well as its relative ChainOpportunity records
  public static void deleteChain(Set<Decimal> unexistchainSet){
    Set<Id> unexistIDSet = (new Map<Id,Chain__c> ([select Id from Chain__c where oci_chain_id__c in :unexistchainSet])).KeySet();  
    delete new List<OpportunityChain__c>([select Id from OpportunityChain__c where ChainId__c in :unexistIDSet]);
    delete new List<Chain__c>([select Id from Chain__c where oci_chain_id__c in :unexistchainSet]);      
  }          

  @future(callout=true)
  webService static void getAllChains() {
    OutcomeChainsSettings__c chainsSettings = OutcomeChainsSettings__c.getOrgDefaults();     
    Map<Decimal,Chain__c> chainMap = populateChainMap();             
    List<Chain__c> chains = new List<Chain__c>(); 
    Set<Decimal> chainSourceSet = new Set<Decimal>();        
    Set<Decimal> unexistchainSet = new Set<Decimal>(); 
    //system.debug('xxxxxxxxx----begin sync');
    JSONParser parser = getParser(chainsSettings.Base_Host_Url__c + '/v1/chain.list?token='+login()+'&tenantId='+String.valueOf(chainsSettings.TeamID__c));    
    while (parser.nextToken() != null) {
      // Start at the array of Chain.
      if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
          while (parser.nextToken() != null) {
              // Advance to the start object marker to find next Chain statement object.
              if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                  // Read entire Chain object
                  Chain c = (Chain)parser.readValueAs(Chain.class);
                  if(c.id==null)
                     continue; 
                  chainSourceSet.add(c.id);                   
                  String s = JSON.serialize(c);
                  system.debug('xxxxxxxxx----Serialized chain:'+ s);
                  Chain__c chainObj = null; 
                  if(chainMap.containsKey(c.id)==true) {
                      chainObj = updateChain(c,chainMap.get(c.id));
                  }
                  else {
                      chainObj = addChain(c,chainsSettings.Base_Host_Url__c + '/#chain/'); 
                  }                
                  if(chainObj!=null){
                      chains.add(chainObj);
                  }  
                  // Skip the child start array and start object markers.
                  parser.skipChildren();
              }
          }
       } 
    }
    
    unexistchainSet=getUnexistchainSet(chainMap.KeySet(),chainSourceSet);
      
    deleteChain(unexistchainSet);
     
    try {
        upsert chains;
        //system.debug('done');
    } catch(DmlException e){
        //system.debug('error');
    }         
  }
 
 // for testing
 /* 
   private static void testAddDummyChains(){
      List<Chain__c> chains = new List<Chain__c>(); 
      Chain__c chainObj = new Chain__c();
      chainObj.ChainURL__c='https://test1.outcomechains.com';
      chainObj.Description__c='test chain1';
      chainObj.oci_chain_id__c=239921822;
      chainObj.Name='test chain1';
      chainObj.isTemplate__c=false;    
      chainObj.Chain_Owner__c='zhitao_yan@live.com';
      chainObj.Chain_External_User__c='oc.sfdc@ociconnect.com'; 
      chainObj.ChainUpdateTime__c =Datetime.now();
      chains.add(chainObj);
      chainObj = new Chain__c();
      chainObj.ChainURL__c='https://test2.outcomechains.com';
      chainObj.Description__c='test chain2';
      chainObj.oci_chain_id__c=239921823;
      chainObj.Name='test chain2';
      chainObj.isTemplate__c=true;    
      chainObj.Chain_Owner__c='zhitao_yan@live.com';
      chainObj.Chain_External_User__c='oc.sfdc1@ociconnect.com'; 
      chainObj.ChainUpdateTime__c =Datetime.now();
      chains.add(chainObj);      
        try {
            upsert chains;
            //system.debug('done');
        } catch(DmlException e){
            //system.debug('error');
        }   
      System.assert(1==1);
    }
    
*/    

    public class Chain {
        public String shareMode;
        public String name;
        public String tenantId;
        public String ctime;
        public Decimal id;
        public String cuserId;
        public String uuserId;  
        public String isTemplate;
        public String chainOwnerUserName;
        public String chainOwnerExternalUserName; 
        public String utime;
    }
}