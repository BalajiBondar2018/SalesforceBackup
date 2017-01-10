public class AccountContactNestedPagingExtension {
public List<AccountContactWrapper> accConWrapperList = new List<AccountContactWrapper>();

    public AccountContactNestedPagingExtension(ApexPages.StandardController controller) {
        for(Account accountObj :  [select Id,Name,(select LastName from Contacts) from Account LIMIT 10]){
        accConWrapperList.add(new AccountContactWrapper(accountObj,accountObj.contacts));
        }
        System.debug('@@@@@@@@@@@@AccountContactWrapperList '+accConWrapperList );
    }


public List<AccountContactWrapper> getAccountContactWrapperList(){
return accConWrapperList ;
}
    
    public class AccountContactWrapper{
    public Integer rowNo {get;set;}
    public Account account{get;set;}
    public List<Contact> contactList{get;set;}
        public AccountContactWrapper(Account acc , List<Contact> conList){
            account = acc;
            contactList = conList;
       }
    }
}