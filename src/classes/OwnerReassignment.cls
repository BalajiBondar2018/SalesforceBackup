global class OwnerReassignment implements Database.Batchable<sObject>{
public List<ErrorLog__c> ErrorLogList = new List<ErrorLog__c>();
    global Database.querylocator start(Database.BatchableContext BC){
                return Database.getQueryLocator('select Id,OwnerId from Account where Rep_Manager__c == NULL LIMIT 100');
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
    System.debug('@@@@@@@@@@@@@Inside execute method.');   
       
       List<Account> accountList = new List<Account>();
       for(sObject s : scope){Account a = (Account)s;
                a.Name='Test Batch Account';
                accountList.add(a);
            
            }

    if (accountList.size() > 0) {
        Database.SaveResult[] lsr = Database.update(accountList , false);
        Integer recordid = 0;
        for (Database.SaveResult SR : lsr) {
            if (!SR.isSuccess()) {
                ErrorLog__c ErrorLogObj = new ErrorLog__c(RecordId__c= accountList[recordid].id, Error_Description__c=SR.getErrors()[0].getMessage());
                System.debug('@@@@@@@@@@@@@ErrorLogObj  '+ErrorLogObj);
                ErrorLogList.add(ErrorLogObj);
            }
        recordid++;
        }
    }
    
    System.debug('@@@@@@@@@@@@@ErrorLogList.size() '+ErrorLogList.size());
    System.debug('@@@@@@@@@@@@@ErrorLogList '+ErrorLogList);
    
    if (ErrorLogList.size() > 0) {
        insert ErrorLogList;
    }
  }//End of execute method
    
    global void finish(Database.BatchableContext BC){
    System.debug('@@@@@@@@@@@@@Inside finish method.');  
    }
}