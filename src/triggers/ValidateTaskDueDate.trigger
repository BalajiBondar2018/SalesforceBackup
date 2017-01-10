trigger ValidateTaskDueDate on Task (before insert, before update) {
//variable decleration
Map<Id, Task> taskIdTaskMap = new Map<Id, Task>();
Set<Id> caseIdSet = new Set<Id>();
Map<Id, Date> caseIdDueDateMap = new Map<Id, Date>();
String case_prefix = Schema.SObjectType.Case.getKeyPrefix();
    
    try{
        //Filter tasks related to case with event Before Insert
        if(Trigger.isBefore && Trigger.isInsert){
            for(Task taskObj : Trigger.new){
                if(taskObj.WhatId != Null && ((String)taskObj.WhatId).startsWith(case_prefix)){
                    taskIdTaskMap.put(taskObj.Id , taskObj);
                    caseIdSet.add(taskObj.WhatId);      
                }
            }
        }   
        //Filter tasks related to case with event Before Update 
        if(Trigger.isBefore && Trigger.isUpdate){
            for(Task taskObj : Trigger.new){
                if(taskObj.WhatId != Null && ((String)taskObj.WhatId).startsWith(case_prefix) && Trigger.oldMap.get(taskObj.Id).ActivityDate != Trigger.newMap.get(taskObj.Id).ActivityDate){
                    taskIdTaskMap.put(taskObj.Id , taskObj);
                    caseIdSet.add(taskObj.WhatId);      
                }
            }
        }   
        System.debug('@@@@@@caseIdSet '+caseIdSet);
        //Retrieve all the cases with due date information  
        for(Case caseObj :[select Id, OfficeDepot__Due_Date__c from Case where Id IN : caseIdSet]){
            caseIdDueDateMap.put(caseObj.Id , caseObj.OfficeDepot__Due_Date__c);    
        }
        System.debug('@@@@@@caseIdDueDateMap '+caseIdDueDateMap);   
        //validate task due date with workcase due date     
        for(Task taskobj : taskIdTaskMap.values()){
            if(taskobj.ActivityDate > caseIdDueDateMap.get(taskobj.WhatId)){
            System.debug('@@@@@@ Error condition TRUE.');
                taskobj.addError('Task due date should not be greater than workcase due date.('+ caseIdDueDateMap.get(taskobj.WhatId) +').');
            }
        }
    }catch(Exception ex){
        System.debug('@@@@@@@@@@@@error '+ex);
    }
}