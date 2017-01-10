trigger LeadEmailBouncedValidation on Lead (before update) {
    for(Lead leadobj: Trigger.New){
        System.debug('@@@@@@@@@@@@@@@@@ leadobj.EmailBouncedDate'+leadobj.EmailBouncedDate);
        if(leadobj.EmailBouncedDate != Null) {
        leadobj.Email_Bounced_Date__c = System.Today();}
    }

}