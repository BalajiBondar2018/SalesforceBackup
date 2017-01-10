public class opportunityList2Con {
    // Initialize setCon and return a list of records 
    public List<Account> getOpportunities() {
    List<Account> accountList = [select id, Name from Account limit 1000];
    return accountList ;
    }
}