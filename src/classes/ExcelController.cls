public class ExcelController {
    public List<Account> getAccountList(){
    List<Account> accountList = [select Id, Name from Account LIMIT 5];
    return accountList;
    }
    
    public List<Opportunity> getOpportunityList(){
    List<Opportunity> OpportunityList= [select Id, Name, AccountId, Amount, StageName from Opportunity LIMIT 5];
    return OpportunityList;
    }
}