public class Paging5Controller {

public List<AccountWrapper> accountWrapperList {get;set;}
    
    public PageReference ShowResultClick() {
        accountWrapperList = new List<AccountWrapper>();
        for(Account account : [select Id, Name, OwnerId, phone, fax, CreatedDate from Account LIMIT 35]){
        accountWrapperList.add(new AccountWrapper(account , FALSE)); 
        }
    
    return null;
    }

    
    
    
    
    public class AccountWrapper{
    public Account accountObj{get;set;}
    public boolean isSelected {get;set;}
    public AccountWrapper(Account accountObj, boolean isSelected){
        this.accountObj = accountObj;
        this.isSelected = isSelected;
    }
    }
}