public class ImplementationRequestFormExtension {
public Implementation__c implementationObj = new Implementation__c();
public Opportunity opportunityObj {get;set;}
public Implementation__c getimplementationObj(){
return implementationObj ;
} 
public Boolean showGenaralSectionFlag{get;set;}
public Boolean showOrganizationDetailsFlag{get;set;}
public Boolean showOpportunityDetailsFlag{get;set;}
public Boolean showCustomerDetailsFlag{get;set;}
public Boolean showImplementationDetailsFlag{get;set;}
public Boolean showB2BFlag{get;set;}
public Boolean showBSMFlag{get;set;}
public Boolean showPrecisionPayFlag{get;set;}

public boolean IsSubmittedforApproval{get;set;}



    public ImplementationRequestFormExtension(ApexPages.StandardController controller) {
    opportunityObj = (Opportunity) controller.getRecord();
    if(opportunityObj.Id != null){
            opportunityObj = [select Id, Name from Opportunity where Id=:opportunityObj.Id LIMIT 1];
            
            implementationObj = [Select i.General_Opportunity_Deal_Review__c ,i.General_NACS_Status_Required__c ,i.General_NACS_Status_Required_Description__c, i.General_Currency1__c, i.General_Currency2__c, i.General_Currency3__c , 
                                        i.General_NBMADMName__c, i.General_RequiredResource__c, i.PrecisionPay_SolutionType__c, i.PrecisionPay_PaymentInitiationPoint__c,
                                        i.PrecisionPay_Need__c, i.PrecisionPay_CustomerRequirement__c, i.Opportunity__c, i.Opportunity_Product5__c,
                                        i.Opportunity_Product4__c, i.Opportunity_Product3__c, i.Opportunity_Product2__c, i.Opportunity_Product1__c, i.Name,
                                        i.Implementation_SolutionLaunch__c,i.Implementation_ResourceConstraints__c, i.Id, i.General_Contract_Sent_Status__c,
                                        i.General_Contract_Sent_Description__c  
                                        From Implementation__c i where i.Opportunity__c=:opportunityObj.Id LIMIT 1];
    }
    
    showGenaralSectionFlag = true;
    }
    
    public pagereference BackBtnClick(){
    if(showOrganizationDetailsFlag == true){  showOrganizationDetailsFlag = false ; showGenaralSectionFlag = true; }
    else if(showOpportunityDetailsFlag == true){  showOpportunityDetailsFlag = false ; showOrganizationDetailsFlag = true; }
    else if(showCustomerDetailsFlag == true){  showCustomerDetailsFlag = false ; showOpportunityDetailsFlag = true; }
    else if(showImplementationDetailsFlag == true){  showImplementationDetailsFlag = false ; showCustomerDetailsFlag = true; }
    else if(showB2BFlag == true){  showB2BFlag = false ; showImplementationDetailsFlag = true; }
    else if(showBSMFlag == true){  showBSMFlag = false ; showB2BFlag = true; }
    else if(showPrecisionPayFlag  == true){  showPrecisionPayFlag = false ; showBSMFlag = true; }
    
    commitImplementationRequestChanges();
    
    return null;
    }
    
    public pagereference NextBtnClick(){
    if(showGenaralSectionFlag == true){  showGenaralSectionFlag = false ; showOrganizationDetailsFlag = true; }
    else if(showOrganizationDetailsFlag == true){  showOrganizationDetailsFlag = false ; showOpportunityDetailsFlag = true; }
    else if(showOpportunityDetailsFlag == true){  showOpportunityDetailsFlag = false ; showCustomerDetailsFlag = true; }
    else if(showCustomerDetailsFlag == true){  showCustomerDetailsFlag = false ; showImplementationDetailsFlag = true; }
    else if(showImplementationDetailsFlag == true){  showImplementationDetailsFlag = false ; showB2BFlag = true; }
    else if(showB2BFlag == true){  showB2BFlag = false ; showBSMFlag = true; }
    else if(showBSMFlag == true){  showBSMFlag = false ; showPrecisionPayFlag = true; }
    
    commitImplementationRequestChanges();
    
    return null;
    }
    
    public pagereference GeneralNACSStatusOnChange(){
    System.debug('@@@@@@@@ GeneralNACSStatusOnChange() called.');
    //if(implementationObj.General_NACS_Status_Required__c == 'False') 
    implementationObj.General_NACS_Status_Required_Description__c = '';
    //commitImplementationRequestChanges();
    return null;
    }
    
    public pagereference BackToOpportunity(){
    Pagereference oppPage = new Pagereference('/'+ opportunityObj.Id);
    oppPage.setRedirect(true);
    return oppPage;
    }
  
    public pagereference SubmitBtnClick(){
    IsSubmittedforApproval = true;
    commitImplementationRequestChanges();
    
    return null;
    }

    public void commitImplementationRequestChanges(){
    update implementationObj;
    }

}