trigger UpdateWorkcaseStatus on OfficeDepot__Work_Case_Item__c (after delete) {
//variable deceleration
Set<Id> workcaseIdSet = new Set<Id>();
List<Case> workcaseList = new List<Case>();

    if(Trigger.isAfter && Trigger.isDelete){
        for(OfficeDepot__Work_Case_Item__c WCIObj : Trigger.old){
            workcaseIdSet.add(WCIObj.OfficeDepot__Case__c);//retrieve WCI related workcase  
    }
    
    for(Case caseObj : [select Id, Status, (select Id, Status__c from  OfficeDepot__Work_Case_Items__r where Status__c = 'Open') from Case where Status ='WCI In Progress' AND Id IN :workcaseIdSet]){
            if(caseObj.OfficeDepot__Work_Case_Items__r.size() == 0){
                caseObj.Status = 'Open';//update the status to open
                workcaseList.add(caseObj);
            }   
    }
    update workcaseList;//perform workcase status update
    }
}