public class SearchAuthExtension {
    public boolean showAuthResult {get;set;}
    public Account accountObj {get;set;}
    public Contact contactObj {get;set;}
    public List<Account> accountList = new List<Account>();
    
    public List<Account> getaccountList(){
        accountList = [select id, Name, Phone,CreatedDate,(Select c.OfficeDepot__Phone_Value_2__c, c.OfficeDepot__Phone_Value_1__c, c.OfficeDepot__Phone_Type_2__c,c.CreatedDate, 
                            c.OfficeDepot__Phone_Type_1__c, c.OfficeDepot__Id_Value_4__c, c.OfficeDepot__Id_Value_3__c, 
                            c.OfficeDepot__Id_Value_2__c, c.OfficeDepot__Id_Value_1__c, c.OfficeDepot__Id_Type_4__c, 
                            c.OfficeDepot__Id_Type_3__c, c.OfficeDepot__Id_Type_2__c, c.OfficeDepot__Id_Type_1__c, 
                            c.OfficeDepot__Furnisher_Name__c, c.OfficeDepot__Detailed_Id_Type_4__c, c.OfficeDepot__Detailed_Id_Type_3__c, 
                            c.OfficeDepot__Detailed_Id_Type_2__c, c.OfficeDepot__Detailed_Id_Type_1__c, c.MailingStreet, c.MailingStateCode, 
                            c.MailingState, c.MailingPostalCode, c.MailingCountryCode, c.MailingCountry, c.MailingCity, c.LastName, c.FirstName,
                            c.Email From Contacts c LIMIT 2) from Account LIMIT 20];
        return accountList;
    }

    public SearchAuthExtension(ApexPages.StandardController controller) {
        showAuthResult = false;
    }
 
    public pagereference SearchBtnClick(){
        showAuthResult = true;
        return null;
    }
    
    public pagereference CancelBtnClick(){
    showAuthResult = false;
    return null;
    }

}