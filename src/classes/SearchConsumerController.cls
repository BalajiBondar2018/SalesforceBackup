public class SearchConsumerController {
public List<Contact> contactList = new List<Contact>();
public boolean showConsumerSearchResultFlag {get;set;}
public contact contactObj {get;set;}
public String selectedConsumerType {get;set;}

public List<Contact> getcontactList(){
contactList =[Select c.OfficeDepot__Phone_Value_2__c, c.OfficeDepot__Phone_Value_1__c, c.OfficeDepot__Phone_Type_2__c, 
                                c.OfficeDepot__Phone_Type_1__c, c.OfficeDepot__Id_Value_4__c, c.OfficeDepot__Id_Value_3__c, 
                                c.OfficeDepot__Id_Value_2__c, c.OfficeDepot__Id_Value_1__c, c.OfficeDepot__Id_Type_4__c, 
                                c.OfficeDepot__Id_Type_3__c, c.OfficeDepot__Id_Type_2__c, c.OfficeDepot__Id_Type_1__c, 
                                c.OfficeDepot__Furnisher_Name__c, c.OfficeDepot__Detailed_Id_Type_4__c, c.OfficeDepot__Detailed_Id_Type_3__c, 
                                c.OfficeDepot__Detailed_Id_Type_2__c, c.OfficeDepot__Detailed_Id_Type_1__c, c.MailingStreet, c.MailingStateCode, 
                                c.MailingState, c.MailingPostalCode, c.MailingCountryCode, c.MailingCountry, c.MailingCity, c.LastName, c.FirstName,c.OfficeDepot__Search_Begin_Date__c,c.OfficeDepot__Search_End_Date__c, 
                                c.Email From Contact c LIMIT 10];
return contactList ;
}


public SearchConsumerController(){
selectedConsumerType = 'Consumer';
}



public Pagereference SearchClick(){
showConsumerSearchResultFlag = true;
return null;
}

public Pagereference CancelClick(){
showConsumerSearchResultFlag = false;
return null;
}

public Pagereference CreateCaseClick(){
PageReference caseEditPage= new PageReference('/500/e?retURL=%2F500%2Fo');
    caseEditPage.setRedirect(true);
    return caseEditPage;

}

public Pagereference ConsumerTypeChange(){

return null;
}



}