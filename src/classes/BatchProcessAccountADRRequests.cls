public class BatchProcessAccountADRRequests{
    public static void ExecuteBatch(){
    List<Account> updateAccountList = new List<Account>();
    List<ADR_Request__c> deleteADRRequestList = new List<ADR_Request__c>();  
      
    List<ADR_Request__c> adrrequestList = [select Id, Lead__c, Lead__r.LastName, Account__c, Account__r.Name, New_Owner__c, Request_Status__c  from ADR_Request__c];
        System.debug('@@@@@@@@@@@adrrequestList '+adrrequestList );    
        for(ADR_Request__c adrrequestObj :adrrequestList ){
	        //Update the SOQL filter condition to Today() == ADR_Process_Date__c
	        //update the Account with the ADR request status 'Approved'
	        if(adrrequestObj.Request_Status__c == 'Approved'){
		        Account accountObj = new Account(Id=adrrequestObj.Account__c);
		        accountObj.OwnerId = adrrequestObj.New_Owner__c;
		        updateAccountList.add(accountObj);
		        //clear the ADR Request Queue with the request status 'Approved'
		        deleteADRRequestList.add(adrrequestObj);
		        //Add Logic to transfer all the Account related information to newly assigned owner 
	        }
	        else if(adrrequestObj.Request_Status__c == 'Rejected'){
		        //clear the ADR Request Queue with the request status 'Rejected'
		        deleteADRRequestList.add(adrrequestObj);
	        }
        }
    delete deleteADRRequestList;
    update updateAccountList;   
    }
}