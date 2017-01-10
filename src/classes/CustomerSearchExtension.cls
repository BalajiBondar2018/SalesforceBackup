public class CustomerSearchExtension {
public Case caseObj = new Case();

    public Case getcaseObj (){
    if(caseId != Null) caseObj = [select Id, CaseNumber, Account.Name from Case where Id=:caseId];
    return caseObj ;
    }
    
    public void setcaseObj (Case caseObj ){
    this.caseObj = caseObj ;
    }


    public Id caseId;
    public Id getcaseId(){
    return caseId ;
    }
    
    public void setcaseId(Id caseId){
    this.caseId  = caseId ;
    }

    public CustomerSearchExtension(ApexPages.StandardController controller) {
    
    }

}