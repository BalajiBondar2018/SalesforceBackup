trigger NotifyFurnisher on Case (before insert , before update , after insert, after update) {
    //variable declearion
    public List<OfficeDepot__Work_Case_Item__c> WCIObjList = new List<OfficeDepot__Work_Case_Item__c>();
    
    //retrieve organization holiday details
	List<Holiday> holidayList =[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
	System.debug('@@@@@@@@@holidayList '+holidayList);
              
    if(Trigger.isBefore && Trigger.isInsert){
        for(Case caseObj : Trigger.new){
        	if(caseObj.OfficeDepot__Notice_Date__c != Null)
	    		caseObj.OfficeDepot__Business_Days1__c = calculateWorkingDaysBetweenTwoDates(caseObj.OfficeDepot__Notice_Date__c, System.Today(), holidayList); 
	    }
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
    	for(Case caseObj : Trigger.new){
    		if(Trigger.oldMap.get(caseObj.Id).OfficeDepot__Notice_Date__c != caseObj.OfficeDepot__Notice_Date__c)
    			caseObj.OfficeDepot__Business_Days1__c = calculateWorkingDaysBetweenTwoDates(caseObj.OfficeDepot__Notice_Date__c, System.Today(), holidayList);
    	}
    }
    
    
    //create WCI for new workcase insert;check notify furnisher condition
    if(Trigger.isAfter && Trigger.isInsert){
        for(Case caseObj : Trigger.new){
            if(caseObj.OfficeDepot__Notify_Furnisher_CRA__c == 'No'){
                //insert a new WCI record
                WCIObjList.add(createWCIObj(caseObj));
            }
        }
    }
    
    //create WCI for workcase update;check notify furnisher condition
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Case caseObj : Trigger.new){
            if(Trigger.oldMap.get(caseObj.Id).OfficeDepot__Notify_Furnisher_CRA__c == 'Yes' && caseObj.OfficeDepot__Notify_Furnisher_CRA__c == 'No'){
                //insert a new WCI record
                WCIObjList.add(createWCIObj(caseObj));
            }
        }
    }
    
    if(WCIObjList.size() != 0)
        insert WCIObjList;
    //create WCI Object
    public static OfficeDepot__Work_Case_Item__c createWCIObj(Case caseObj){
        OfficeDepot__Work_Case_Item__c WCIObj = new OfficeDepot__Work_Case_Item__c();
        WCIObj.OfficeDepot__Request__c = 'Notify Furnisher';
        WCIObj.OfficeDepot__Notify_Furnisher_CRA__c = TRUE;
        WCIObj.OfficeDepot__Status__c = 'New';
        WCIObj.OfficeDepot__Due_Date__c = System.today();
        WCIObj.OfficeDepot__Case__c = caseObj.Id;
        return WCIObj;
    }
    
    //support methods
	public static Integer calculateWorkingDaysBetweenTwoDates(Date date1,Date date2 ,List<Holiday> holidays){
	    System.debug('@@@@@@@@@date1 '+date1);
	    System.debug('@@@@@@@@@date2 '+date2);
	    
	    Integer allDaysBetween = date1.daysBetween(date2);
	    System.debug('@@@@@@@@@allDaysBetween '+allDaysBetween);
	    Integer allWorkingDays=0;
	    for(Integer k=0;k<allDaysBetween ;k++ ){
	        if(checkifItisWorkingDay(date1.addDays(k),holidays)){
	            allWorkingDays++;
	        } 
	    } 
	    return allWorkingDays;
	}
	
	public static boolean checkifItisWorkingDay(Date currentDate,List<Holiday> holidays){
	    Date weekStart  = currentDate.toStartofWeek();
	    for(Holiday hDay:holidays){
	            if(currentDate.daysBetween(hDay.ActivityDate) == 0){
	                     return false;
	            }
	    }
	   if(weekStart.daysBetween(currentDate) ==0 || weekStart.daysBetween(currentDate) == 6){
	           return false;
	    } else 
    return true;
	}   
}