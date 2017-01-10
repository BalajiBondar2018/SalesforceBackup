public class SearchFurnisherExtension {
Case caseObj;
    public SearchFurnisherExtension(ApexPages.StandardController controller) {
       
    }


public List<Contact> contactList = new List<Contact>();
public boolean showConsumerSearchResultFlag {get;set;}

public List<Contact> getcontactList(){
contactList =[Select c.OfficeDepot__Phone_Value_2__c, c.OfficeDepot__Phone_Value_1__c, c.OfficeDepot__Phone_Type_2__c, 
                                c.OfficeDepot__Phone_Type_1__c, c.OfficeDepot__Id_Value_4__c, c.OfficeDepot__Id_Value_3__c, 
                                c.OfficeDepot__Id_Value_2__c, c.OfficeDepot__Id_Value_1__c, c.OfficeDepot__Id_Type_4__c, 
                                c.OfficeDepot__Id_Type_3__c, c.OfficeDepot__Id_Type_2__c, c.OfficeDepot__Id_Type_1__c, 
                                c.OfficeDepot__Furnisher_Name__c, c.OfficeDepot__Detailed_Id_Type_4__c, c.OfficeDepot__Detailed_Id_Type_3__c, 
                                c.OfficeDepot__Detailed_Id_Type_2__c, c.OfficeDepot__Detailed_Id_Type_1__c, c.MailingStreet, c.MailingStateCode, 
                                c.MailingState, c.MailingPostalCode, c.MailingCountryCode, c.MailingCountry, c.MailingCity, c.LastName, c.FirstName,c.OfficeDepot__Search_Begin_Date__c,c.OfficeDepot__Search_End_Date__c, 
                                c.Email From Contact c LIMIT 1];
return contactList ;
}

public Pagereference SearchClick(){
showConsumerSearchResultFlag = true;
return null;
}

public Pagereference CancelClick(){
showConsumerSearchResultFlag = false;
return null;
}

public Pagereference LinkToCaseClick(){
    //PageReference caseEditPage= new PageReference('/500/e?retURL=%2F500%2Fo');
    //caseEditPage.setRedirect(true);
    //return caseEditPage;
    
    PageReference casePage= new PageReference(system.currentpagereference().getparameters().get('retURL'));
    casePage.setRedirect(true);
    return casePage;
    
     

}

    public pagereference TestRedirect(){
        Account accountOBj = new Account(Name='TestAccount',phone='3243243244');
        insert accountObj;
        
        pagereference accountpage = new pagereference ('/'+ accountobj.Id);
        //pagereference accountpage = new ApexPages.StandardController(accountObj).view();
        accountpage.setRedirect(true);
        return accountpage;
    }




}