public class AccountPlanExtesion {
public Account_Plan__c AccountPlanObj {get;set;}
public Objective__c ObjectiveObj {get;set;}
public Account_Clone__c AccountCloneObj {get;set;}
public List<Contact_Clone__c> ContactCloneObjList {get;set;}
public List<Opportunity_Clone__c> openOpportunityCloneObjList {get;set;}
public List<Opportunity_Clone__c> closedOpportunityCloneObjList {get;set;}

public String accountId;
public Id accountPlanId;    
public Account accountObj{get;set;}
String query='';    
public boolean isSubmittedforApproval{get;set;}
public boolean showSubmittedforApproval{get;set;}

public boolean showAccountPlanFlag {get;set;}
public boolean showObjectiveFlag {get;set;}
public boolean showAccountFlag {get;set;}
public boolean showContactFlag {get;set;}
public boolean showOpportunityFlag {get;set;}
public boolean showSubmitFlag {get;set;}

    public AccountPlanExtesion(ApexPages.StandardController controller) {
    showAccountPlanFlag = true;
    //Fetch Account Id from retURL & Account Plan Id from id parameter
    AccountId = apexpages.currentpage().getparameters().get('retURL');
    AccountId =AccountId.substring(1 , AccountId.length());
    accountObj = [select Id, Name from Account LIMIT 1];
    
    AccountPlanId = apexpages.currentpage().getparameters().get('id');
    
        //If Account Plan doesn't Exists(New Button Click) 
        if(accountId!=null && AccountPlanId==null){
        IsSubmittedforApproval = false;
        showSubmittedforApproval = false;
        //query Account,Contact,Opportunity details
        query = 'select ' +  getObjectFields('Account') +',(select '+ getObjectFields('Contact') +' from Contacts),(select '+ getObjectFields('Opportunity') +' from Opportunities) from Account where Id=\''+ AccountId +'\'';
        accountObj = database.query(query);
            //set Account Plan object values
            AccountPlanObj = new Account_Plan__c();
            AccountPlanObj.Request_Status__c = '';
            AccountPlanObj.Requested_On__c = null;
            //set Objective object values
            ObjectiveObj = new Objective__c();
            ObjectiveObj.Description__c ='';
            ObjectiveObj.Objective_Type__c = '';
            
            //fetch the Account details and copy to Account Clone
            AccountCloneObj = new Account_Clone__c();
            AccountCloneObj.ref_account__c = accountObj.Id;
            AccountCloneObj.Name__c = accountObj.Name;
            AccountCloneObj.AccountNumber__c = accountObj.AccountNumber;
            AccountCloneObj.Owner__c = accountObj.OwnerId;
            AccountCloneObj.Last_Month__c = accountObj.Last_Month__c;
            AccountCloneObj.YTD__c = accountObj.YTD__c;
            AccountCloneObj.Rolling_12_Months__c = accountObj.Rolling_12_Months__c;
            
            //fetch the Contact List details and copy to Contact Clone List
            ContactCloneObjList = new List<Contact_Clone__c>();
            for(Contact contactObj : accountObj.contacts){
                Contact_Clone__c tempcontactCloneObj = new Contact_Clone__c();
                tempcontactCloneObj.ref_contact__c = contactObj.Id;
                tempcontactCloneObj.LastName__c = contactObj.LastName;
                tempcontactCloneObj.FirstName__c = contactObj.FirstName;
                tempcontactCloneObj.Email__c = contactObj.Email;
                tempcontactCloneObj.Phone__c = contactObj.Phone;
                ContactCloneObjList.add(tempcontactCloneObj);
            }
            //fetch the Opportunity List details and copy to Opportunity Clone List
            openOpportunityCloneObjList = new List<Opportunity_Clone__c>();
            closedOpportunityCloneObjList = new List<Opportunity_Clone__c>();
            
            for(Opportunity oppObj : accountObj.opportunities){
                Opportunity_Clone__c tempoppCloneObj = new Opportunity_Clone__c();
                tempoppCloneObj.ref_Opportunity__c = oppObj.Id;
                tempoppCloneObj.Opportunity_Name__c = oppObj.Name;
                tempoppCloneObj.Quantity__c = oppObj.TotalOpportunityQuantity;
                tempoppCloneObj.Product__c = oppObj.Product__c;
                tempoppCloneObj.Closed_Date__c = oppObj.CloseDate;
                tempoppCloneObj.Stage__c = oppObj.StageName;
                if(tempoppCloneObj.Stage__c == 'Closed Won' || tempoppCloneObj.Stage__c == 'Closed Lost')
                    closedOpportunityCloneObjList.add(tempoppCloneObj); 
                else 
                    openOpportunityCloneObjList.add(tempoppCloneObj);
            }
        }
        //If Account Plan Exists(Edit Button Click) 
        else{
        //query Account Plan with Account Clone,Contact Clone,Opportunity Clone details 
        //query = 'Select ' +  getObjectFields('Account_Plan__c') +' , (Select ' +  getObjectFields('Objective__c') +' From Objective__r), (Select '+  getObjectFields('Account_Clone__c') +' From AccountClone__r) From Account_Plan__c where Id=\''+ accountPlanId +'\'';
        //AccountPlanObj = database.query(query);
        }
    }
    
    public Pagereference BackToAccountBtnClick(){
    PageReference accountPage = new Pagereference('/'+ AccountId); 
    accountPage.setRedirect(true);
    return accountPage;
    }
    
    public Pagereference PreviousBtnClick(){
    if(showSubmitFlag == true) { showSubmitFlag = false; showOpportunityFlag = true;}
    else if(showOpportunityFlag == true) { showOpportunityFlag = false; showContactFlag = true;}
    else if(showContactFlag == true) { showContactFlag = false; showAccountFlag = true;}
    else if(showAccountFlag == true) { showAccountFlag = false; showObjectiveFlag = true;}
    else if(showObjectiveFlag == true) { showObjectiveFlag = false; showAccountPlanFlag = true;}
        
    return null;
    }
    
    public Pagereference NextBtnClick(){
    if(showAccountPlanFlag == true) { showAccountPlanFlag = false; showObjectiveFlag = true; }    
    else if(showObjectiveFlag == true) { showObjectiveFlag = false; showAccountFlag = true; }
    else if(showAccountFlag == true) { showAccountFlag = false; showContactFlag = true; }
    else if(showContactFlag == true) { showContactFlag = false; showOpportunityFlag = true; }
    else if(showOpportunityFlag == true) { showOpportunityFlag = false; showSubmitFlag = true; }
    
    return null;
    }
    
    public Pagereference SubmitforApprovalBtnClick(){
    IsSubmittedforApproval = true;
    return null;
    }


//-----------------------------------------------------Support Method----------------------------------------------------------------------------
//pass object name to get all fields for sObject record
    public String getObjectFields(string objName) {
        String fieldnames = '';
        try {
            Map < String, Schema.SObjectType > m = Schema.getGlobalDescribe();
            Schema.SObjectType s = m.get(objName);
            Schema.DescribeSObjectResult r = s.getDescribe();

            //get fields
            Map < String, Schema.SObjectField > fields = r.fields.getMap();
            for (string field: fields.keySet()) {
                if (fieldnames == '') {
                    fieldnames = field;
                } else {
                    fieldnames += ',' + field;
                }
            }
        } catch (Exception e) {
            System.debug('get Fields Error' + e.getMessage());
            ApexPages.addMessages(e);
            return null;
        }
        return fieldnames;
    }
}