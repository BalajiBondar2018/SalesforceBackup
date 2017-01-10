trigger PopulateCaseParameter on Case (before insert, before update) {
    //variable decleration
    public Map<string, OfficeDepot__Global_Variable__c> problemTypeGlobalVariableMap = new Map<string, OfficeDepot__Global_Variable__c>();
    //retrieve all global variable records
    for(OfficeDepot__Global_Variable__c globalVariableObj : [select Id, OfficeDepot__Problem_Category__c, OfficeDepot__Response_Deadline_Date_Attorney_General__c, OfficeDepot__Response_Deadline_Date_Default__c from OfficeDepot__Global_Variable__c]){
        problemTypeGlobalVariableMap.put(globalVariableObj.OfficeDepot__Problem_Category__c,globalVariableObj); 
    }
    System.debug('@@@@@@@@@@@@@problemTypeGlobalVariableMap '+problemTypeGlobalVariableMap);
    
    for(Case caseObj : Trigger.New){
        //assign appropriate Global Variable record to case
        System.debug('@@@@@@@@@@@@@ map key check '+problemTypeGlobalVariableMap.containskey(caseObj.OfficeDepot__Problem_Category__c));        
        if(problemTypeGlobalVariableMap.containskey(caseObj.OfficeDepot__Problem_Category__c)){
            caseObj.OfficeDepot__Global_Variable__c = problemTypeGlobalVariableMap.get(caseObj.OfficeDepot__Problem_Category__c).Id;
        }
        //calculate case Due Date
        
        if(caseObj.OfficeDepot__Notice_Received_From__c == 'Attorney General' || caseObj.OfficeDepot__Issue_Type__c == 'Complaint'){
            if(problemTypeGlobalVariableMap.get(caseObj.OfficeDepot__Problem_Category__c) != Null)
                caseObj.OfficeDepot__Due_Date__c = System.Today() +Integer.valueOf(problemTypeGlobalVariableMap.get(caseObj.OfficeDepot__Problem_Category__c).OfficeDepot__Response_Deadline_Date_Attorney_General__c);
        }
        else{
            //assign default due date to case from global variable
            if(problemTypeGlobalVariableMap.get(caseObj.OfficeDepot__Problem_Category__c) != Null)
                caseObj.OfficeDepot__Due_Date__c = System.Today() +Integer.valueOf(problemTypeGlobalVariableMap.get(caseObj.OfficeDepot__Problem_Category__c).OfficeDepot__Response_Deadline_Date_Default__c);
        }
    }
}