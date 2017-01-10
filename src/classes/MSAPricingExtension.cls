Public Class MSAPricingExtension{
    //variable decleration
    public Id caseId;
    public List<Task> caseTaskList = new List<Task>(); 
    public String selectedBusinessUnit {get;set;}
    public String selectedPotentialLiability {get;set;}
    public String resolutionPlanNote {get;set;}
    
    
    public Id getcaseId(){
    return caseId ;
    }
    
    public void setcaseId(Id caseId){
    this.caseId  = caseId ;
    }
    
    public List<Task> getcaseTaskList(){
        if(caseId != Null)
            caseTaskList = [select id, Subject, Description, Priority, Status, activitydate, CreatedDate  from Task where whatid=:caseId order by CreatedDate desc LIMIT 10];
        return caseTaskList;
    }
    
    public void setcaseTaskList(List<Task> caseTaskList ){
    this.caseTaskList  = caseTaskList ;
    }

    public MSAPricingExtension(ApexPages.StandardController controller) {
    string updateCaseId = Apexpages.currentPage().getParameters().get('updateCaseId');
    System.debug('@@@@@@@@@@@@@@@@ onload MSAPricingExtension'+updateCaseId);
    }
    
    public Pagereference SubmitClick(){
    System.debug('@@@@@@@@@@@@@@@SubmitClick');
    
    return null;
    }
    
    public Pagereference CancelClick(){
    System.debug('@@@@@@@@@@@@@@@CancelClick'); 
    selectedBusinessUnit = 'SelectOption';
    selectedPotentialLiability = 'SelectOption';
    resolutionPlanNote = '';
    
    return null;
    }
    

}