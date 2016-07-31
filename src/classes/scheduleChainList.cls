global class scheduleChainList {

    static String jobName='scheduleChainSyncApex';

    public scheduleChainList(chainList controller) {
    }

    webService static void scheduleChainSync() {
       //OutcomeChainsSettings__c chainsSettings = OutcomeChainsSettings__c.getInstance(UserInfo.getUserId());
       OutcomeChainsSettings__c chainsSettings = OutcomeChainsSettings__c.getOrgDefaults();
       String jobId = System.schedule(jobName,
                                       chainsSettings.Cron_Expression__c, 
                                       new chainList());
   }
   
   webService static void abortChainSync(){
        
        list<CronTrigger> con=[SELECT CreatedById,CreatedDate,CronExpression,CronJobDetailId,EndTime,Id,LastModifiedById,NextFireTime,OwnerId,PreviousFireTime,StartTime,State,TimesTriggered,TimeZoneSidKey FROM CronTrigger where CronJobDetail.Name=:jobName];
        for(CronTrigger ct:con)
        {
           system.abortjob(ct.id);
        }
   }
   
   webService static Integer existChainSync(){
       Integer isExist = 0;
       list<CronTrigger> con=[SELECT Id FROM CronTrigger where CronJobDetail.Name=:jobName];
       if(con != null && con.size()>0){
           isExist=1;
       }
       return isExist;
   } 
   
   
}