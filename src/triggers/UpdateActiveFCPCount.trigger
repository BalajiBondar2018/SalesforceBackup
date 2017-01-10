trigger UpdateActiveFCPCount on Flexible_Contract_Price__c (after insert, after update) {
public Map<Id,Account> AccountActiveFCPCountMap = new Map<Id,Account>();
    if(Trigger.isAfter && Trigger.isInsert){
        for(Flexible_Contract_Price__c FCPObj : [select Id, Status__c, Contract__r.AccountId, Contract__r.Account.Active_FCPs__c from Flexible_Contract_Price__c where Id IN:Trigger.New]){
            Account accountObj = new Account(Id = FCPObj.Contract__r.AccountId, Active_FCPs__c=FCPObj.Contract__r.Account.Active_FCPs__c);
            if(AccountActiveFCPCountMap.ContainsKey(accountObj.Id)){
                Account tempaccountObj = AccountActiveFCPCountMap.get(accountObj.Id); 
                if(FCPObj.Status__c =='Activated') tempaccountObj.Active_FCPs__c = tempaccountObj.Active_FCPs__c + 1;
                else tempaccountObj.Active_FCPs__c = tempaccountObj.Active_FCPs__c - 1;
            
            } 
            else{
                if(FCPObj.Status__c =='Activated') accountObj.Active_FCPs__c = accountObj.Active_FCPs__c + 1;
                else accountObj.Active_FCPs__c = accountObj.Active_FCPs__c - 1;
            }    
            if(accountObj.Active_FCPs__c < 0) accountObj.Active_FCPs__c = 0; 
            AccountActiveFCPCountMap.put(accountObj.Id,accountObj);
        }
        if(AccountActiveFCPCountMap.size()>0) update AccountActiveFCPCountMap.values(); 
    }
    
    
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Flexible_Contract_Price__c NewFCPObj : [select Id, Status__c, Contract__r.AccountId, Contract__r.Account.Active_FCPs__c from Flexible_Contract_Price__c where Id IN:Trigger.New]){
        Flexible_Contract_Price__c OldFCPObj = Trigger.oldMap.get(NewFCPObj.id);    
            if(NewFCPObj.Status__c != OldFCPObj.Status__c){
                Account accountObj = new Account(Id = NewFCPObj.Contract__r.AccountId, Active_FCPs__c=NewFCPObj.Contract__r.Account.Active_FCPs__c);
                if(AccountActiveFCPCountMap.ContainsKey(accountObj.Id)){
                    Account tempaccountObj = AccountActiveFCPCountMap.get(accountObj.Id); 
                    if(NewFCPObj.Status__c =='Activated') tempaccountObj.Active_FCPs__c = tempaccountObj.Active_FCPs__c + 1;
                    else tempaccountObj.Active_FCPs__c = tempaccountObj.Active_FCPs__c - 1;
                    
                    if(tempaccountObj.Active_FCPs__c < 0) tempaccountObj.Active_FCPs__c = 0; 
                    AccountActiveFCPCountMap.put(tempaccountObj.Id,tempaccountObj);
        
                } 
                else{
                    if(NewFCPObj.Status__c =='Activated') accountObj.Active_FCPs__c = accountObj.Active_FCPs__c + 1;
                    else accountObj.Active_FCPs__c = accountObj.Active_FCPs__c - 1;
                    
                    if(accountObj.Active_FCPs__c < 0) accountObj.Active_FCPs__c = 0; 
                    AccountActiveFCPCountMap.put(accountObj.Id,accountObj);
                }    
                
            }    
        }
        if(AccountActiveFCPCountMap.size()>0) update AccountActiveFCPCountMap.values(); 
    }    
    
}