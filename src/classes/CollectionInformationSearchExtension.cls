public class CollectionInformationSearchExtension {
public boolean displayPopup {get; set;}  
    public CollectionInformationSearchExtension(ApexPages.StandardController controller) {

    }



public List<Contact> contactList = new List<Contact>();
public boolean showConsumerSearchResultFlag {get;set;}

public List<Contact> getcontactList(){
contactList =[select Id, FirstName, LastName,Email,fax, OfficeDepot__Detailed_Id_Type_1__c, OfficeDepot__Id_Value_1__c, OfficeDepot__Id_Type_1__c from Contact LIMIT 1];
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

public Pagereference CreateCaseClick(){
//PageReference caseEditPage= new PageReference('/500/e?retURL=%2F500%2Fo');
  //  caseEditPage.setRedirect(true);
//    return caseEditPage;
return null;
}



 public void closePopup() {        

        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
 }