public with sharing class AccountDisplayExtension {
public List<Account> accountList {get;set;}
    public AccountDisplayExtension(ApexPages.StandardController controller) {
           accountList =[select Id, Name , (select Id, FirstName from Contacts LIMIT 10) from Account LIMIT 10]; 
    }

}