public class WorkcaseReassignmentController {
//variable decleration
public String selectedCaseType {get;set;}
public String selectedOperationType {get;set;}
public String selectedReassignmentCriteria {get;set;}
public String selectedQueueName {get;set;}
public String selectedFromAgent {get;set;}
public String selectedToAgent {get;set;}
public String selectedCaseFilterCriteria {get;set;}
public String selectedCaseFilterInput {get;set;}
public String selectedReassignmentReason {get;set;}
//Boolean Flags to disable the input fields
public Boolean disableReassignmentCriteriaFlag {get;set;}
public Boolean disableOperationTypeFlag {get;set;}
public Boolean disableReassignmentQueueFlag {get;set;}
public Boolean disableFromAgentFlag {get;set;}
public Boolean disableToAgentFlag {get;set;}
public Boolean disableCaseFilterCriteriaFlag {get;set;}
public Boolean disableCaseFilterInputFlag {get;set;}
public Boolean disableReassignmentReasonFlag {get;set;}

    //--------------------------------------------Object Queue---------------------------------------------------------------------------------------
    public List<SelectOption> getqueueNameList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select','--Select--'));
        
        String selectedselectedCaseTypeLocal = '';
        if(selectedCaseType == 'WorkCase'|| selectedCaseType == 'SubscriberCase') selectedselectedCaseTypeLocal ='Case';
        else if(selectedCaseType == 'OfficeDepot__Work_Case_Item__c') selectedselectedCaseTypeLocal ='OfficeDepot__Work_Case_Item__c';
        
        //Retrieve the queue information related to selected object type(workcase, subscriber case, workcaseitem)
        for(QueueSobject queueobj : [Select q.Id, q.SobjectType, q.Queue.Type, q.Queue.Name, q.QueueId From QueueSobject q where q.SobjectType=:selectedselectedCaseTypeLocal order by q.Queue.Name]){
            options.add(new SelectOption(queueobj.QueueId,queueobj.Queue.Name));    
        }
    return options;
    }

    //--------------------------------------------Operation Type----------------------------------------------------------------------------------------        
    public List<SelectOption> getOperationTypeList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select','--Select--'));
        options.add(new SelectOption('ReAssign','ReAssign'));
        options.add(new SelectOption('Assign','Assign'));

    return options;
    }
    
    //--------------------------------------------From Agent----------------------------------------------------------------------------------------        
    public List<SelectOption> getFromAgentList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select','--Select--'));
        //Retrieve the user list under selected Queue
        for(User userobj : [Select Id, Name from User where IsActive = TRUE order by Name]){
            options.add(new SelectOption(userobj.Id,userobj.Name)); 
        }
    return options;
    }
    
    //--------------------------------------------To Agent----------------------------------------------------------------------------------------        
    public List<SelectOption> getToAgentList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select','--Select--'));
        //Retrieve the user list under selected Queue
        for(User userobj : [Select Id, Name from User where IsActive = TRUE order by Name]){
            System.debug('@@@@@@@@@@@@@@@selectedFromAgent '+selectedFromAgent);
            if(String.valueOf(userobj.Id) != selectedFromAgent) 
                options.add(new SelectOption(userobj.Id,userobj.Name)); 
        }
    return options;
    }
    
    //--------------------------------------------Case Filter Options------------------------------------------------------------------------------        
    public List<SelectOption> getFilterCriteriaList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select','--Select--'));
        if(selectedCaseFilterCriteria =='Status'){
            Schema.DescribeFieldResult fieldResult = Case.Status.getDescribe();
            List<Schema.PicklistEntry> casestatusPickListOptions = fieldResult.getPicklistValues();
                
            for( Schema.PicklistEntry f : casestatusPickListOptions){
              options.add(new SelectOption(f.getLabel(), f.getValue()));
            }  
        }
        else if(selectedCaseFilterCriteria =='Priority'){
            Schema.DescribeFieldResult fieldResult = Case.Priority.getDescribe();
            List<Schema.PicklistEntry> casestatusPickListOptions = fieldResult.getPicklistValues();
                
            for( Schema.PicklistEntry f : casestatusPickListOptions){
              options.add(new SelectOption(f.getLabel(), f.getValue()));
            }  
        }
    return options;
    }
    
    //--------------------------------------------Action Methods---------------------------------------------------------------------------------        
    public Pagereference OnLoad(){
        disableReassignmentCriteriaFlag = TRUE;
        disableOperationTypeFlag = TRUE;
        disableReassignmentQueueFlag = TRUE;
        disableFromAgentFlag = TRUE;
        disableToAgentFlag = TRUE;
        disableCaseFilterCriteriaFlag = TRUE;
        disableCaseFilterInputFlag = TRUE;
        disableReassignmentReasonFlag = TRUE;
    return null;
    }
    
    public Pagereference CaseTypeChange(){
        if(selectedCaseType != 'Select'){
            disableReassignmentCriteriaFlag = FALSE;
            disableReassignmentQueueFlag = TRUE;
            disableOperationTypeFlag = FALSE;
            disableFromAgentFlag = TRUE;
            disableToAgentFlag = TRUE;
            disableCaseFilterCriteriaFlag = TRUE;
            disableCaseFilterInputFlag = TRUE;
            disableReassignmentReasonFlag = TRUE;
            
            selectedOperationType = 'Select';
            selectedReassignmentCriteria = 'Select';
            selectedQueueName = 'Select';
            selectedFromAgent = 'Select';
            selectedToAgent = 'Select';
            selectedCaseFilterCriteria = 'Select';
            selectedCaseFilterInput='';
            selectedReassignmentReason = 'Select';
            selectedReassignmentReason = 'Select';
        }
        else{
            ClearSearchParameters();
            disableOperationTypeFlag = TRUE;
        }
    return null;
    }
    
    
    public Pagereference OperationTypeChange(){
        
        if(selectedOperationType== 'Select'){
            disableReassignmentQueueFlag  = TRUE;
        }
        else{
            disableReassignmentQueueFlag  = FALSE;
        }
            selectedQueueName = 'Select';
            selectedFromAgent = 'Select';
            selectedToAgent = 'Select';
            selectedCaseFilterCriteria = 'Select';
            selectedCaseFilterInput='';
            selectedReassignmentReason = 'Select';
            
            disableFromAgentFlag = TRUE;
            disableToAgentFlag = TRUE;
            disableCaseFilterCriteriaFlag = TRUE;
            disableCaseFilterInputFlag = TRUE;
            disableReassignmentReasonFlag = TRUE;
            
            
            
        
        
    return null;
    }
    
    
    
     public Pagereference QueueChange(){
         if(selectedOperationType== 'Select' || selectedQueueName == 'Select'){
            disableFromAgentFlag = TRUE;
            disableToAgentFlag = TRUE;
            disableCaseFilterCriteriaFlag = TRUE;
            disableCaseFilterInputFlag = TRUE;
            disableReassignmentReasonFlag = TRUE;
            
            selectedFromAgent = 'Select';
            selectedToAgent = 'Select';
            selectedCaseFilterCriteria = 'Select';
            selectedCaseFilterInput='';
            selectedReassignmentReason = 'Select';
            selectedReassignmentReason = 'Select';
         }else if(selectedOperationType == 'ReAssign'){
            disableFromAgentFlag = FALSE;
            disableToAgentFlag = FALSE;

            selectedFromAgent = 'Select';
            selectedToAgent = 'Select';
         }
         else{
            disableFromAgentFlag = TRUE;
            disableToAgentFlag = FALSE;

            selectedFromAgent = 'Select';
            selectedToAgent = 'Select';
         }
         
         
         
         
         

     return null;
     }
    
   
    
    public Pagereference ReassignmentCriteriaChange(){
        if(SelectedReassignmentCriteria == 'Select'){
            disableReassignmentQueueFlag = FALSE;
            disableFromAgentFlag = FALSE; 
        }
        else if(SelectedReassignmentCriteria == 'Queue'){
            disableReassignmentQueueFlag = FALSE;
            disableFromAgentFlag = TRUE;
            disableToAgentFlag = FALSE;
            
            selectedFromAgent = 'Select';
            selectedToAgent = 'Select';
        }
        else if(SelectedReassignmentCriteria == 'Agent'){
            selectedQueueName = 'Select';
            
            disableReassignmentQueueFlag = TRUE;
            disableFromAgentFlag = FALSE;
            
            selectedFromAgent = 'Select';
            selectedToAgent = 'Select';
        }       
        return null;
    }
    
    public Pagereference FromAgentChange(){
        disableCaseFilterCriteriaFlag = FALSE;
        if(selectedFromAgent != 'Select') 
            disableToAgentFlag = FALSE;
        else{
            disableToAgentFlag = TRUE;
            selectedToAgent = 'Select';
        }
        
        getToAgentList();
    return null;
    
    }
    
    public Pagereference ToAgentChange(){
        disableCaseFilterCriteriaFlag = FALSE;
    return null;
    }
    
    public Pagereference CaseFilterCriteriaChange(){
        disableCaseFilterInputFlag = FALSE;
        disableReassignmentReasonFlag = FALSE;
    return null;
    }
    
    public Pagereference ReassignBtnClick(){
        
    return null;
    }
    
    public Pagereference CancelBtnClick(){
        ClearSearchParameters();    
    return null;
    }
    
    //--------------------------------------------Support Methods--------------------------------------------------------------------------------        
    public void ClearSearchParameters(){
        selectedCaseType = 'Select';
        selectedOperationType = 'Select';
        selectedReassignmentCriteria = 'Select';
        selectedQueueName = 'Select';
        selectedFromAgent = 'Select';
        selectedToAgent = 'Select';
        selectedCaseFilterCriteria = 'Select';
        selectedCaseFilterInput='';
        selectedReassignmentReason = 'Select';
        
        disableReassignmentCriteriaFlag = TRUE;
        disableReassignmentQueueFlag = TRUE;
        disableFromAgentFlag = TRUE;
        disableToAgentFlag = TRUE;
        disableCaseFilterCriteriaFlag = TRUE;
        disableCaseFilterInputFlag = TRUE;
        disableReassignmentReasonFlag = TRUE;
    }
}