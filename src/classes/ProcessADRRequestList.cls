global class ProcessADRRequestList implements Database.Batchable<sObject> {
    global String ADRReqestQueryString;
    
    global ProcessADRRequestList(String q){
   		ADRReqestQueryString  = q;
	}
    global Database.QueryLocator start(Database.BatchableContext BC){       
      //Fetch all the FCP records satisfing the condition
      System.debug('@@@@@ADRReqestQueryString '+ADRReqestQueryString);
      return Database.getQueryLocator(ADRReqestQueryString);
    }  
    
    global void execute(Database.BatchableContext BC, List<sObject> sObjectList){
    System.debug('@@@@@execute Method called.');
    
    //variable decleration
    Set<Id> leadIdSet = new Set<Id>();
    Set<Id> accountIdSet = new Set<Id>(); 
    List<Lead> leadList = new List<Lead>();
    List<Account> accountList = new List<Account>();
    Map<Id,ADR_Request__c> LeadAccountIDADRRequestMap = new Map<Id,ADR_Request__c>();
    List<Lead> updateLeadList = new List<Lead>();
    List<Account> updateAccountList = new List<Account>();
    List<Contact> updateContactList = new List<Contact>();
    List<Contract> updateContractList = new List<Contract>();
    List<ADR_Request__c> adrrequestList = new List<ADR_Request__c>();
    List<ADR_Request__c> processadrrequestOwnerReAssignmentList = new List<ADR_Request__c>();
     
    adrrequestList = (List<ADR_Request__c>) sObjectList;
    System.debug('@@@@@@@@@@@@@@@adrrequestList.size() '+adrrequestList.size());
    System.debug('@@@@@@@@@@@@@@@adrrequestList '+adrrequestList);
    
    //Process only ADR Request with status 'Approved'
    for(ADR_Request__c adrrequestObj : adrrequestList){
	    if(adrrequestObj.Request_Status__c == 'Approved')
	    processadrrequestOwnerReAssignmentList.add(adrrequestObj);	
    }
    System.debug('@@@@@@@@@@@@@@@processadrrequestOwnerReAssignmentList.size() '+processadrrequestOwnerReAssignmentList.size());
    System.debug('@@@@@@@@@@@@@@@processadrrequestOwnerReAssignmentList '+processadrrequestOwnerReAssignmentList);
    
    if(processadrrequestOwnerReAssignmentList.size()>0){
	    for(ADR_Request__c adrrequestObj : processadrrequestOwnerReAssignmentList){
		    if(adrrequestObj.Lead__c != null){
		    	LeadAccountIDADRRequestMap.put(adrrequestObj.Lead__c , adrrequestObj);
		    	leadIdSet.add(adrrequestObj.Lead__c);
		    }
		    else if(adrrequestObj.Account__c != null){
		    	LeadAccountIDADRRequestMap.put(adrrequestObj.Account__c , adrrequestObj);
		    	accountIdSet.add(adrrequestObj.Account__c);
		    }
	    }
    }
    //Fetch all the Lead & Account records for Owner and related information reassignment
    if(leadIdSet.size()>0){
	    leadList = [Select l.Id, l.OwnerId From Lead l where l.Id IN : leadIdSet];
	    System.debug('@@@@@@@@@@@@@@@leadList.size() '+leadList.size());
	    System.debug('@@@@@@@@@@@@@@@leadList '+leadList);
    }
    if(accountIdSet.size()>0){
	    accountList = [Select a.OwnerId, a.Id,(Select Id, OwnerId From Contracts), (Select Id, OwnerId From Contacts) From Account a where a.Id IN : accountIdSet];
	    System.debug('@@@@@@@@@@@@@@@accountList.size() '+accountList.size());
	    System.debug('@@@@@@@@@@@@@@@accountList '+accountList);
    }
    
    //Process Lead,Open Activities letter change 
    if(leadList.size()>0){
	    for(Lead leadObj : leadList){
		    leadObj.OwnerId = LeadAccountIDADRRequestMap.get(leadObj.Id).New_Owner__c;	
		    updateLeadList.add(leadObj);
	    }
    List<Database.Saveresult> leadupdateSaveResult =  Database.update(updateLeadList);
    System.debug('@@@@@@@@@@@@@@@leadupdateSaveResult '+leadupdateSaveResult);
	}
    
        
    
    //Process Account,Open Activities,Contact,Contract letter change
    if(accountList.size()>0){
	    for(Account accountObj : accountList){
		    accountObj.OwnerId = LeadAccountIDADRRequestMap.get(accountObj.Id).New_Owner__c;	
		    updateAccountList.add(accountObj);
		    	for(Contact contactObj : accountObj.Contacts){
		    		contactObj.OwnerId = LeadAccountIDADRRequestMap.get(accountObj.Id).New_Owner__c;	
		    		updateContactList.add(contactObj);
		    	}
		    	
		    	for(Contract contractObj : accountObj.Contracts){
		    		contractObj.OwnerId = LeadAccountIDADRRequestMap.get(accountObj.Id).New_Owner__c;	
		    		updateContractList.add(contractObj);
		    	}
	    }
	    
	    List<Database.Saveresult> accountupdateSaveResult =  Database.update(updateAccountList);
	    System.debug('@@@@@@@@@@@@@@@accountupdateSaveResult '+accountupdateSaveResult);
	    //if(leadupdateSaveResult == true){
	    Database.update(updateContactList);
	    Database.update(updateContractList);
	    //}
    }
    
    System.debug('@@@@@@@@@@@@@@@End of ADR Request Processing.');
    
    //delete all the ADR reqests with status Approved or Rejected
    if(adrrequestList.size()>0)
    Database.delete(adrrequestList);  
    
    }
    
    //Inform via Email to the batch running user(System Admin or ADM Admin) 
    global void finish(Database.BatchableContext BC){
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob 
									WHERE Id =:BC.getJobId()];
	    // Send an email to the Apex job's submitter notifying of job completion. 
	    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	    String[] toAddresses = new String[] {a.CreatedBy.Email};
	    mail.setToAddresses(toAddresses);
	    mail.setSubject('ADR Request Batch Processing Status:' + a.Status);
	    mail.setPlainTextBody('The batch Apex job processed:' + a.TotalJobItems +' batches with:'+ a.NumberOfErrors + ' failures.');
	    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
}