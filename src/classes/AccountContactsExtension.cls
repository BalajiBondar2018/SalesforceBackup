public class AccountContactsExtension {
public Account accountObj {get;set;}
public Contact newContactObj {get;set;}
public List<Contact> contactList {get;set;}
    public AccountContactsExtension(ApexPages.StandardController controller) {
    accountObj = new Account();
    accountObj =[select Id, Name, Phone from Account LIMIT 1];
    
    contactList = new List<Contact>();
    contactList = [select Id, FirstName,LastName,Email,Phone from Contact LIMIT 5];
    }

}