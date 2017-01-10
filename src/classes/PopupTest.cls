public with sharing class PopupTest {    
    public List<account> getAccounts()  
    {  
        List<account> accounttList = new List<account>();  
        accounttList = [Select Id, Name from Account LIMIT 10];  
        return accounttList ;  
    }  
  
}