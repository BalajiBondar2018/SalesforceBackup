public class SearchCasesController {
public List<Case> caseList = new List<Case>();
public boolean showConsumerSearchResultFlag {get;set;}

public List<Case> getcaseList(){
caseList =[select Id,CaseNumber,ContactId, Contact.Name from Case LIMIT 5];
return caseList ;
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
 

}