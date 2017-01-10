public class AccountPlanPage2Extension {
        public Account_Plan__c accountPlanObj =new Account_Plan__c();
        public Account_Plan__c getaccountPlanObj(){
            if(AccountPlanId != null)
            accountPlanObj = [Select  a.account__r.YTD__c, a.account__r.Rolling_12_Months__c, a.account__r.Last_Month__c, a.Account_Plan_Name__c , a.Requested_On__c, a.Request_Status__c, a.Name, a.Id, a.CreatedDate, a.Approved_Rejected_On__c, a.account__r.Name, a.Approved_Rejected_By__c, a.Account__c, a.account__r.BillingStreet, a.account__r.BillingState, a.account__r.BillingPostalCode, a.account__r.BillingCountry, a.account__r.BillingCity,(Select Id, Name, Account_Plan__c, Objective_Type__c, Description__c From Objective__r LIMIT 1) From Account_Plan__c a where a.Id=:AccountPlanId LIMIT 1];
            return  accountPlanObj;
        }
        
        public Objective__c objectiveObj = new Objective__c();
        public Objective__c getobjectiveObj(){
        return  objectiveObj;
        }
                
        public accountClonewrapper accountClonewrapperObj;
        public accountClonewrapper getaccountClonewrapperObj(){
            return accountClonewrapperObj;
        }
        public List<contactClonewrapper> contactClonewrapperObjList = new List<contactClonewrapper>();
        public List<contactClonewrapper> getcontactClonewrapperObjList(){
            return contactClonewrapperObjList;
        }
        
        public List<opportunityClonewrapper> openopportunityClonewrapperObjList = new List<opportunityClonewrapper>();
        public List<opportunityClonewrapper> getopenopportunityClonewrapperObjList(){
            return openopportunityClonewrapperObjList;
        }
        
        public List<opportunityClonewrapper> closedopportunityClonewrapperObjList = new List<opportunityClonewrapper>();
        public List<opportunityClonewrapper> getclosedopportunityClonewrapperObjList(){
        return closedopportunityClonewrapperObjList;
        }
        
        public String accountId;
        public Id accountPlanId;
        
        public boolean isSubmittedforApproval{get;set;}
        public boolean showSubmittedforApproval{get;set;}
        
        public boolean showAccountPlanFlag {get;set;}
        public boolean showObjectiveFlag {get;set;}
        public boolean showAccountFlag {get;set;}
        public boolean showContactFlag {get;set;}
        public boolean showOpportunityFlag {get;set;}
        public boolean showSubmitFlag {get;set;}
        
        Account_Clone__c accountclone = new Account_Clone__c();
    	List<Contact_Clone__c> contactcloneList = new List<Contact_Clone__c>();
    	List<Opportunity_Clone__c> opportunitycloneList = new List<Opportunity_Clone__c>();
    
    
    	//constructor
        public AccountPlanPage2Extension(ApexPages.StandardController controller) {
        ////System.debug('@@@@@@@ Constructor called.');    
        
        showAccountPlanFlag = true;
        AccountPlanId = apexpages.currentpage().getparameters().get('id');
        
        //System.debug('@@@@@@@ AccountPlanId '+AccountPlanId);
    
        accountPlanObj = [Select  a.account__r.YTD__c, a.account__r.Rolling_12_Months__c, a.account__r.Last_Month__c, a.Account_Plan_Name__c , a.Requested_On__c, a.Request_Status__c, a.Name, a.Id, a.CreatedDate, a.Approved_Rejected_On__c, a.Approved_Rejected_By__c, a.Account__c, a.account__r.Name, a.account__r.BillingStreet, a.account__r.BillingState, a.account__r.BillingPostalCode, a.account__r.BillingCountry, a.account__r.BillingCity,(Select Id, Name, Account_Plan__c, Objective_Type__c, Description__c From Objective__r LIMIT 1) From Account_Plan__c a where a.Id=:AccountPlanId LIMIT 1];                
        for(Objective__c objective : accountPlanObj.Objective__r) objectiveObj = objective;
        
        for(Account_Clone__c accountcloneObj : [select Id, owner__r.Name, Name__c, AccountNumber__c, Owner__c, Ref_Account__c, Ref_Account__r.OwnerId, Ref_Account__r.Name ,Ref_Account__r.AccountNumber,Ref_Account__r.YTD__c, Ref_Account__r.Rolling_12_Months__c, Ref_Account__r.Last_Month__c, Ref_Account__r.BillingStreet, Ref_Account__r.BillingCity, Ref_Account__r.BillingState, Ref_Account__r.BillingCountry, Ref_Account__r.BillingPostalCode,
                                                (Select Id, AccountClone__c, FirstName__c, LastName__c, Phone__c, Email__c, Ref_Contact__c, Ref_Contact__r.FirstName, Ref_Contact__r.LastName, Ref_Contact__r.Phone, Ref_Contact__r.Email From Contact_Clone__r),
                                                (Select Id,  AccountClone__c, Closed_Date__c, Stage__c, Opportunity_Name__c, Ref_Opportunity__c, Quantity__c, Product__c,ref_Opportunity__r.Name,ref_Opportunity__r.TotalOpportunityQuantity, ref_Opportunity__r.Product__c, ref_Opportunity__r.CloseDate, ref_Opportunity__r.StageName From Opportunity_Clone__r) 
                                                from Account_Clone__c where ref_account__c=:accountPlanObj.Account__c LIMIT 1]){
            accountClonewrapperObj = new accountClonewrapper(createAccountObj(accountcloneObj) , accountcloneObj);
            
            for(Contact_Clone__c contactcloneObj : accountcloneObj.Contact_Clone__r){
                    contactClonewrapperObjList.add(new contactClonewrapper(createContactObj(contactcloneObj),contactcloneObj));
            }
            
            for(Opportunity_Clone__c opportunitycloneObj : accountcloneObj.Opportunity_Clone__r){
                if(opportunitycloneObj.stage__c == 'Closed Won' || opportunitycloneObj.stage__c == 'Closed Lost')       
                    closedopportunityClonewrapperObjList.add(new opportunityClonewrapper(createopportunityObj(opportunitycloneObj),opportunitycloneObj));
                else 
                    openopportunityClonewrapperObjList.add(new opportunityClonewrapper(createopportunityObj(opportunitycloneObj),opportunitycloneObj));
            }
        }       
    //System.debug('@@@@@@@@@@ accountClonewrapperObj '+accountClonewrapperObj);   
    }
    
    public void OnLoad(){
    //System.debug('@@@@@@@ onload called.');
    }
            
    public Pagereference BackToAccountPlanBtnClick(){
    PageReference accountPlanPage = new Pagereference('/'+ accountPlanObj.Id); 
    accountPlanPage.setRedirect(true);
    return accountPlanPage;
    }
    
    public Pagereference QuickSaveBtnClick(){
    Pagereference pageref =  SaveAccountPlanDetails();
    return pageref;
    //return null;
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
    
    public Pagereference SaveAndNextBtnClick(){
    Pagereference pageref = SaveAccountPlanDetails();
    
    if(showAccountPlanFlag == true) { showAccountPlanFlag = false; showObjectiveFlag = true; }    
    else if(showObjectiveFlag == true) { showObjectiveFlag = false; showAccountFlag = true; }
    else if(showAccountFlag == true) { showAccountFlag = false; showContactFlag = true; }
    else if(showContactFlag == true) { showContactFlag = false; showOpportunityFlag = true; }
    else if(showOpportunityFlag == true) { showOpportunityFlag = false; showSubmitFlag = true; }
    
    return pageref;
    }
    
    public Pagereference SubmitforApprovalBtnClick(){
        try{
            //create the new approval request to submit
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(accountPlanObj.Id);
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            // submit the approval request for processing
            Approval.ProcessResult result = Approval.process(req);
            // display if the reqeust was successful
            //System.debug('Submitted for approval successfully: '+result.isSuccess());
        }catch(Exception ex){
            ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(msg);  
            return null; 
        }
        
        //getaccountPlanObj();
        
    return null;
    }
    
    public Pagereference SaveAccountPlanDetails(){
            if(showAccountPlanFlag){
                update accountPlanObj;
                return null;
            }
            else if(showObjectiveFlag){
                    //update objectiveObj;
                    return null;
            }
            else if(showAccountFlag) {
                //update accountClonewrapperObj.accountclone;
                return null;
                }        
                else if(showContactFlag){
                contactcloneList.clear();
                for(contactClonewrapper ccwrapperObj : contactClonewrapperObjList){
                        contactcloneList.add(ccwrapperObj.contactclone);
                }
                //update contactcloneList;
                return null;
                }
            else if(showOpportunityFlag){
                    opportunitycloneList.clear();
                    for(opportunityClonewrapper ocwrapperObj : openopportunityClonewrapperObjList){
                            opportunitycloneList.add(ocwrapperObj.opportunityclone);
                }
                for(opportunityClonewrapper ocwrapperObj : closedopportunityClonewrapperObjList){
                            opportunitycloneList.add(ocwrapperObj.opportunityclone);
                }
                //update opportunitycloneList;
            }
            return null;   
    }

//---------------------------------------------AccountClone Wrapper ---------------------------------------------------------------------
        public class accountClonewrapper{
        public Account account {get;set;}
        public Account_Clone__c accountclone{get;set;}
        public accountClonewrapper(Account a, Account_Clone__c ac){
             this.account = a;  
             this.accountclone = ac;
             }
        }
        
        public Account_Clone__c createAccountCloneObj(Account accountObj){
        Account_Clone__c acloneObj = new Account_Clone__c();
        acloneObj.Ref_Account__c = accountObj.Id;
        acloneObj.Name__c = accountObj.Name;
        acloneObj.AccountNumber__c = accountObj.AccountNumber;
        acloneObj.Owner__c = accountObj.OwnerId;
        return acloneObj;
        }
        
        public Account createAccountObj(Account_Clone__c accountclone){
        Account accObj = new Account();
        accObj.Name = accountclone.Ref_Account__r.Name;
        accObj.AccountNumber = accountclone.Ref_Account__r.AccountNumber;
        accObj.OwnerId = accountclone.Ref_Account__r.OwnerId;
        return accObj;
        }
//---------------------------------------------ContactClone Wrapper ---------------------------------------------------------------------
        public class contactClonewrapper{
        public Contact contact {get;set;}
        public Contact_Clone__c contactclone{get;set;}
        public contactClonewrapper(Contact c, Contact_Clone__c cc){
         this.contact = c;  
             this.contactclone = cc;
            }
        }
        
        public Contact_Clone__c createContactCloneObj(Contact contactObj){
        Contact_Clone__c ccloneObj = new Contact_Clone__c();
        ccloneObj.Ref_Contact__c = contactObj.Id;
        ccloneObj.FirstName__c = contactObj.FirstName;
        ccloneObj.LastName__c = contactObj.LastName;
        ccloneObj.Phone__c = contactObj.Phone;
        ccloneObj.Email__c = contactObj.Email;
        return ccloneObj;
        }
        
        public Contact createContactObj(Contact_Clone__c contactclone){
        Contact conObj = new Contact();
        conObj.FirstName = contactclone.Ref_Contact__r.FirstName;
        conObj.LastName = contactclone.Ref_Contact__r.LastName;
        conObj.Phone = contactclone.Ref_Contact__r.Phone;
        conObj.Email = contactclone.Ref_Contact__r.Email;
        return conObj;
        }
//---------------------------------------------OpportuntiyClone Wrapper ---------------------------------------------------------------------
        public class opportunityClonewrapper{
        public opportunity  opportunity  {get;set;}
        public opportunity_Clone__c opportunityclone{get;set;}
        public opportunityClonewrapper(opportunity  o, opportunity_Clone__c oc){
         this.opportunity  = o;  
             this.opportunityclone = oc;
            }
        }
        
        public opportunity_Clone__c createopportunityCloneObj(opportunity  oppObj){
        opportunity_Clone__c ocloneObj = new opportunity_Clone__c();
        ocloneObj.ref_Opportunity__c = oppObj.Id;
        ocloneObj.Opportunity_Name__c = oppObj.Name;
        ocloneObj.Quantity__c = oppObj.TotalOpportunityQuantity;
        ocloneObj.Product__c = oppObj.Product__c;
        ocloneObj.Closed_Date__c = oppObj.CloseDate;
        ocloneObj.Stage__c = oppObj.StageName;
        return ocloneObj;
        }
        
        public opportunity  createopportunityObj(opportunity_Clone__c opportunityclone){
        opportunity  oppObj = new opportunity ();
        oppObj.Name = opportunityclone.ref_Opportunity__r.Name;
        oppObj.TotalOpportunityQuantity = opportunityclone.ref_Opportunity__r.TotalOpportunityQuantity;
        oppObj.Product__c = opportunityclone.ref_Opportunity__r.Product__c;
        oppObj.CloseDate = opportunityclone.ref_Opportunity__r.CloseDate;
        oppObj.StageName = opportunityclone.ref_Opportunity__r.StageName;
        return oppObj;
        }
}