public class myOutcomeChains{

    public List<Chain__c> getChains() {
        //system.debug('xxxxxxxxxxx----current user:'+UserInfo.getUserName());
        return Database.query(' select oci_chain_id__c,Name,Id,ChainURL__c,Description__c,isTemplate__c,Chain_Owner__c'+ 
                              ' from Chain__c'+
                              ' where Chain_External_User__c=\''+UserInfo.getUserName()+'\'');
    }


    public myOutcomeChains() {

    }

}