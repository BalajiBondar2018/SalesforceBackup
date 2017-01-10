trigger PopulateAccountLastActivityDate on Task (after insert){
    Map<Id,Account> accountIdAccountMap = new Map<Id,Account>();//Map of accounts related to the contacts to be processed
    String Account_prefix = Schema.SObjectType.Account.getKeyPrefix();
    
    for(Task taskObj : Trigger.new){
        if(taskObj.WhatId != Null && ((String)taskObj.WhatId).startsWith(Account_prefix))
            accountIdAccountMap.put(taskObj.WhatId ,new account(id=taskObj.WhatId));
    }
    //fetch the related contact information
    for(Account accountObj :[select id from account where id in :accountIdAccountMap.keyset()]){
        accountObj.Last_Activity_Date__c = System.Today();
        accountIdAccountMap.put(accountObj.Id , accountObj);
    }
    update accountIdAccountMap.values();//update account records with related contact count        
}