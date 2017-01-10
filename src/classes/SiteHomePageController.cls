public class SiteHomePageController {
List<Account> accountList = new List<Account>();

    public PageReference CreateAccount_Click() {
    Account account = new Account(Name='TestAccount');
    insert account;
    return null;
    }

    Public List<Account> getAccounts(){
    accountList = [select Id, Name, Owner.Name, CreatedDate from Account Order By CreatedDate Desc Limit 5];
    return accountList;
    }

}