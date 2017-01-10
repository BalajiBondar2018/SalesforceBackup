public class CreateQuoteExtension {
public Opportunity opportunity{get;set;}
public List<Account> accountList {get;set;}
    public CreateQuoteExtension(ApexPages.StandardController controller) {
    opportunity = (Opportunity)controller.getRecord();
    accountList =[select Id,Name from Account LIMIT 10];
    }

}