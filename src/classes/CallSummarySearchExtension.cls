public class CallSummarySearchExtension {

    public CallSummarySearchExtension(ApexPages.StandardController controller) {

    }

public List<Contact> contactList = new List<Contact>();
public boolean showConsumerSearchResultFlag {get;set;}

public List<Contact> getcontactList(){
contactList =[select Id, FirstName, LastName,Email,fax from Contact LIMIT 10];
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
}