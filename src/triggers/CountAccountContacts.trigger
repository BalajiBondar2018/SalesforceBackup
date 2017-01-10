trigger CountAccountContacts on Contact (after insert ,after update, after delete){
    List<Contact> contactList = new list<contact>();//list of contacts to be processed
    Map<Id,Account> accountIdAccountMap = new Map<Id,Account>();//Map of accounts related to the contacts to be processed
    List<database.Saveresult>  accountSaveResultList = new List<database.Saveresult> ();
    List<Account> accountList = new List<Account>();
    Map<Id, List<Contact>> accoutIdContactListMap = new Map<Id, List<Contact>>();
    
    if(trigger.new!=null)
        contactList.addAll(trigger.new);
    if(trigger.old!=null)
        contactList.addAll(trigger.old);
    //Create a map of accountId and account details
    for(contact c:contactList){ 
        if(c.accountid!=null) 
            accountIdAccountMap.put(c.accountid,new account(id=c.accountid));
    }
    //fetch the related contact information
    for(Account accountObj :[select id,(select id from contacts) from account where id in :accountIdAccountMap.keyset()]){
        accountObj.CountContact__c = accountObj.contacts.size();
        accountIdAccountMap.put(accountObj.Id , accountObj);
        accountList.add(accountObj);
        accoutIdContactListMap.put(accountObj.Id , accountObj.contacts); 
    }
    try{
        update accountIdAccountMap.values();//update account records with related contact count
    } catch( DMLException dmlEx){
        //System.debug('@@@@@@@@@@dmlEx.getNumDml() '+dmlEx.getNumDml());
        for( Integer i = 0; i < dmlEx.getNumDml(); i++ ){
            //System.debug('@@@@@@@@@@dmlEx.getDmlId(i)]  '+dmlEx.getDmlId(i));  
            String errorMessage = 'Error on DQI Score Calculation.'+ dmlEx.getDmlMessage(i);
            //System.debug('@@@@@@@@@@errorMessage  '+errorMessage); 
            //System.debug('@@@@@@@@@@dmlEx.getDmlIndex(i)]  '+dmlEx.getDmlIndex(i));  
            //trigger.newMap.get(contactList[dmlEx.getDmlIndex(i)].Id).addError(errorMessage);
            List<Contact> errorContactList = new List<Contact>();
            errorContactList = accoutIdContactListMap.get(dmlEx.getDmlId(i));
            //System.debug('@@@@@@@@@@errorContactList '+errorContactList); 
            for(Contact contactObj : errorContactList){
                //System.debug('@@@@@@@@@@contactObj '+contactObj );     
                if(trigger.newMap.Containskey(contactObj.Id))
                   trigger.newMap.get(contactObj.id).addError(errorMessage);
            }
        }
    }
    
}