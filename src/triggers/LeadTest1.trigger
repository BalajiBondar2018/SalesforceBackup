trigger LeadTest1 on Lead (before insert ,after insert) {
    if(trigger.isbefore && trigger.isinsert){
        System.debug('@@@@@@@ Trigger before');
        for(Lead leadObj : Trigger.New){
        System.debug('@@@@@@@FirstName' + leadObj.FirstName);
        System.debug('@@@@@@@LastName' + leadObj.LastName);
        System.debug('@@@@@@@company' + leadObj.Company);
        if(leadObj.Company == '') leadObj.Company = leadObj.FirstName + leadObj.LastName;
        
        }
    
    }
    
    if(trigger.isafter && trigger.isinsert){
        System.debug('@@@@@@@ Trigger after');
        for(Lead leadObj : Trigger.New){
            System.debug('@@@@@@@company' + leadObj.Company);        
        }
    
    }
    

}