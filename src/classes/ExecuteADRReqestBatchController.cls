public class ExecuteADRReqestBatchController {
    public void ExecuteBtnClick(){
    String ADRReqestQueryString = 'Select a.Requested_On__c, a.Request_Type__c, a.Request_Status__c, a.OwnerId, a.New_Owner__c, a.Mass_Reassignment__c, a.Id, a.Approved_Rejected_Date__c,a.Lead__c, a.Account__c, a.ADR_Process_Date__c From ADR_Request__c a';
    ProcessADRRequestList batchApex = new ProcessADRRequestList(ADRReqestQueryString);
    ID batchprocessid = Database.executeBatch(batchApex);
    }
}