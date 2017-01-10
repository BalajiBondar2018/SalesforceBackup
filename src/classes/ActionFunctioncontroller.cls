public class ActionFunctioncontroller {
public List<Account> accountList = new List<Account>();
public Id rowId{get;set;}
public Set<Id> roIdSet = new Set<Id>();

    public List<Account> getaccountList(){
    accountList = [select Id,Name from Account LIMIT 5];    
    return accountList;
    }
    
    public void sayHello(){
    System.debug('@@@@@@@@@@@@ sayHello called.');
    System.debug('@@@@@@@rowId '+rowId);
    }
//---------------------------------------select list code ------------------------------------------------    
    String[] countries = new String[]{};
 
    public PageReference test() {
        return null;
    }
 
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));

        return options;
    }
 
    public String[] getCountries() {
        return countries;
    }
 
    public void setCountries(String[] countries) {
        this.countries = countries;
    }
}