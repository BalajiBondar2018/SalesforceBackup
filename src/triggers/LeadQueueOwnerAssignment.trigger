trigger LeadQueueOwnerAssignment on Lead (before insert) {
    //variable decleration
    Map<String,Id> QueueNameQueueIdMap = new Map<String,Id>();//Map to hold the key-pair value for queue Name & queue Id
    //Fetch queues specific to Lead object  
    for(QueueSobject queueObj :[Select q.Id, q.QueueId, q.Queue.Name, q.SobjectType from QueueSobject q where q.SobjectType ='Lead']){
        QueueNameQueueIdMap.put(queueObj.Queue.Name , queueObj.QueueId);        
    }
    System.debug('@@@@@@@@@QueueNameQueueIdMap '+QueueNameQueueIdMap);
        
    for(Lead leadObj : Trigger.New){
        //Add criteria LeadSource, LeadType, Partner(Dummy2)
        if(leadObj.LeadSource == 'Web' && QueueNameQueueIdMap.containsKey('International Leads') == true)
            leadObj.OwnerId = QueueNameQueueIdMap.get('International Leads');
   }
}