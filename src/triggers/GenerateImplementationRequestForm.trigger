/*
Event       : After Update
Description : Create a new Implementation record when Opportunity Stage is updated to 'Closed Won' or 'Closed Lost'
*/
trigger GenerateImplementationRequestForm on Opportunity (After Update) {
//variable decleration
public Set<Id> opportunityIdSet = new Set<Id>();//Set of Opportunity Ids being inserted 
public List<Implementation__c> implementationList = new List<Implementation__c>();//List of Implementation records
public Map<Id,Implementation__c> OppIdExistingImplementationMap = new Map<Id,Implementation__c>();//Map of Opportunity Id and Implementation records
    //check the Opportunity DML Events 
    if(Trigger.isAfter && Trigger.isUpdate){
        //Filter out the Opportunity with appropriate Stage
        for(Opportunity opportunityObj : Trigger.New){
            if(opportunityObj.stageName == 'Closed Won' || opportunityObj.stageName == 'Closed Lost'){  
            opportunityIdSet.add(opportunityObj.Id);
            }
        }
        //check if updated Opportunity do have the existing Implementation record
        for(Implementation__c implementation : [select Id,Opportunity__c from Implementation__c where Opportunity__c IN: opportunityIdSet])
        OppIdExistingImplementationMap.put(implementation.Opportunity__c,implementation);
        
        //Create new Implemenatation Record for the updated Opportunities
        for(Id opportunityObjId : opportunityIdSet){    
            //create new Implementation record only when opportunity don't have existing related Implementation record
            if(!OppIdExistingImplementationMap.containsKey(opportunityObjId)){
                Implementation__c implementationObj = new Implementation__c(Opportunity__c = opportunityObjId);
                implementationList.add(implementationObj);
            }
        }
        //Insert newly created Implementation records
        if(implementationList.size()>0) insert implementationList;
    }
}