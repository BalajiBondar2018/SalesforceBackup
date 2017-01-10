global class AccountBatchErrorHandlingBatch implements Database.Batchable<sObject>{
    public List<ErrorLog__c> ErrorLogList = new List<ErrorLog__c>();
    global Database.querylocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,OwnerId from Account');
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //System.debug('@@@@@ Execute called.');
        List<Account> accountList = new List<Account>();
        for(sObject s : scope){
            Account a = (Account)s;
            a.Name='Test Batch Account';
            accountList.add(a);
        }
        
        //System.debug('@@@@@ accountList.size() '+accountList.size());
        if (accountList.size() > 0) {
            Database.SaveResult[] lsr = Database.update(accountList , false);
            //System.debug('@@@@@@@@@@lsr '+lsr);
            Integer recordid = 0;
            for (Database.SaveResult SR : lsr) {
                if (!SR.isSuccess()) {
                    ErrorLog__c ErrorLogObj = new ErrorLog__c(RecordId__c= accountList[recordid].id, Record_Type__c = 'Account', Error_Description__c=SR.getErrors()[0].getMessage());
                    //System.debug('@@@@@ ErrorLogObj  '+ErrorLogObj );
                    ErrorLogList.add(ErrorLogObj);
                }
                recordid++;
            }
        }
        //System.debug('@@@@@ ErrorLogList '+ErrorLogList);
        
        if (ErrorLogList.size() > 0) {
            insert ErrorLogList;
        }
    }

    global void finish(Database.BatchableContext BC){
    }
}