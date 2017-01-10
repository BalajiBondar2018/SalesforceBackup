trigger PreventDuplicateContact on Contact (before insert,before update) {
    Set<Id> accountIdSet = new Set<Id>();
    Map<Id, Map<String, Contact>> accountIdContactMap = new Map<Id, Map<String, Contact>>();
        
    for(Contact contactObj :Trigger.New){
        accountIdSet.add(contactObj.accountId);
    }
    
    for(Account accountObj : [select Id, (select Id, Email from Contacts) from Account where Id IN: accountIdSet]){
        Map<String, Contact> contactEmailContactMap = new Map<String, Contact>();
        for(Contact contactObj : accountObj.Contacts){
            contactEmailContactMap.put(contactObj.Email , contactObj); 
        }
        accountIdContactMap.put(accountObj.Id ,contactEmailContactMap);
    }
    
    for(Contact contactObj :Trigger.New){
        Map<String, Contact> contactEmailContactMap = new Map<String, Contact>();
        contactEmailContactMap = accountIdContactMap.get(contactObj.accountId);
        if(contactEmailContactMap.containskey(contactObj.Email)){
            contactObj.addError('This Contact already exists.');
        }
    }
}