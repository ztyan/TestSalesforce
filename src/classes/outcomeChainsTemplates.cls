public class outcomeChainsTemplates{

    public List<Chain__c> getTemplates() {
        return Database.query(' select oci_chain_id__c,Name,Id,ChainURL__c,Description__c,isTemplate__c,Chain_Owner__c'+ 
                              ' from Chain__c'+
                              ' where isTemplate__c=true');
    }


    public outcomeChainsTemplates() {

    }

}