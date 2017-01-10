trigger RestrictMultipleADRRequests on ADR_Request__c (Before Insert) {
//variable decleration
public Map<Id,ADR_Request__c> accountIdnewADRMap = new Map<Id,ADR_Request__c>();
public Map<Id,ADR_Request__c> leadIdnewADRMap = new Map<Id,ADR_Request__c>();
public List<ADR_Request__c> AccountRelatedADRRequestList = new List<ADR_Request__c>();
public List<ADR_Request__c> LeadRelatedADRRequestList = new List<ADR_Request__c>();
public Map<Id,List<ADR_Request__c>> accountADRMap = new Map<Id,List<ADR_Request__c>>();
public Map<Id,List<ADR_Request__c>> leadADRMap = new Map<Id,List<ADR_Request__c>>();

    //create a Map of newly created ADR Requests;If duplicate exists records will be eliminated
    for(ADR_Request__c adrrequestObj : Trigger.New){
    System.debug('@@@@@@@@@@@@adrrequestObj '+adrrequestObj );
        if(accountIdnewADRMap.ContainsKey(adrrequestObj.Account__c) || accountIdnewADRMap.ContainsKey(adrrequestObj.Lead__c)){
            adrrequestObj.addError('There is already a existing ADR request against Account/Lead.This request will not be processed.');
        }
        else{
            if(adrrequestObj.Account__c !=Null) accountIdnewADRMap.put(adrrequestObj.Account__c,adrrequestObj);
            if(adrrequestObj.Lead__c !=Null) leadIdnewADRMap.put(adrrequestObj.Lead__c,adrrequestObj);
        }
    }
    
    //Fetch All existing ADR Requests under accounts, leads
    List<ADR_Request__c> AllADRRequestList = [select Id,Account__c,Lead__c from ADR_Request__c where 
                                                (Account__c IN : accountIdnewADRMap.keyset() or Lead__c IN :leadIdnewADRMap.keyset())
                                                and (Request_Status__c = 'Approved' or Request_Status__c = 'InProgress')];
    System.debug('@@@@@@@@@@@@AllADRRequestList '+AllADRRequestList);
    
    //seperate account/lead specific existing ADR requests;This will save 1 DML Query
    for(ADR_Request__c adrrequestObj : AllADRRequestList ){
        if(adrrequestObj.Account__c !=Null)AccountRelatedADRRequestList.add(adrrequestObj);  
        if(adrrequestObj.Lead__c !=Null)LeadRelatedADRRequestList.add(adrrequestObj);
    }
    //Create a Map of existing Accounts and their related ADR Requests
    for(ADR_Request__c adrrequestObj : AccountRelatedADRRequestList){
            List<ADR_Request__c> adrrequestObjList = new List<ADR_Request__c>();
            if(accountADRMap.containsKey(adrrequestObj.Account__c)){
                adrrequestObjList = accountADRMap.get(adrrequestObj.Account__c);
                adrrequestObjList.add(adrrequestObj);
                accountADRMap.put(adrrequestObj.Account__c,adrrequestObjList);
            }
            else{
                adrrequestObjList.add(adrrequestObj);
                accountADRMap.put(adrrequestObj.Account__c,adrrequestObjList); 
            }
    }
    //Create a Map of existing Leads and their related ADR Requests    
    for(ADR_Request__c adrrequestObj : LeadRelatedADRRequestList){
            List<ADR_Request__c> adrrequestObjList = new List<ADR_Request__c>();
            if(accountADRMap.containsKey(adrrequestObj.Lead__c)){
                adrrequestObjList = accountADRMap.get(adrrequestObj.Lead__c);
                adrrequestObjList.add(adrrequestObj);
                leadADRMap.put(adrrequestObj.Lead__c,adrrequestObjList); 
            }
            else{
                adrrequestObjList.add(adrrequestObj);
                leadADRMap.put(adrrequestObj.Lead__c,adrrequestObjList); 
            }
    }
    
    //check the existance of ADR Request with the Account;if YES show the error message for the newly inserted ADR request    
    for(Id accountId :accountADRMap.Keyset()){
        if(accountADRMap.get(accountId).size() >0) accountIdnewADRMap.get(accountId).addError('There is existing ADR Request with status InProgress/Approved.');
    }
    //check the existance of ADR Request with the Lead ;if YES show the error message for the newly inserted ADR request    
    for(Id leadId : leadADRMap.Keyset()){
        if(leadADRMap.get(leadId).size() >0) leadIdnewADRMap.get(leadId).addError('There is existing ADR Request with status InProgress/Approved.');
    }
        
}