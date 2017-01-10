global class CCWPEmailToCaseReopenHandler implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
      //variable decleration
      Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
      Case caseobj = new Case();
      String subToCompare = 'CCWP Case Reopen';
      String emailSubjectStr = email.Subject;

        //'CCWP Case Update case#00001016'
        //System.debug('@@@@@@@@@@@@@@@@email.plainTextBody '+email.plainTextBody);  
        //System.debug('@@@@@@@@@@@@@@@@email.Subject'+email.Subject);
        //System.debug('@@@@@@@@@@@@@@@@email.fromAddress'+email.fromAddress);
        //System.debug('@@@@@@@@@@@@@@@@envelope.fromAddress'+envelope.fromAddress);
      
        if(email.subject.containsIgnoreCase(subToCompare)){
            Group CCWPOpenCaseQueueObj = [Select g.Name, g.Id From Group g where g.Name='CCWP Open Case Queue' LIMIT 1];
            System.debug('@@@@@@@@@@@@@@@@CCWPOpenCaseQueueObj '+CCWPOpenCaseQueueObj );
            
            List<String> splittedEmailSubjectStr = emailSubjectStr.split('#'); 
            System.debug('@@@@@@@@@@@@@@@@splittedEmailSubjectStr '+splittedEmailSubjectStr);
            
            caseobj = [select Id,casenumber from case where casenumber=:splittedEmailSubjectStr[1] LIMIT 1];
            
            if(caseobj !=Null){
                caseobj.Subject = 'Case Reopend using APEX Mail Service';
                caseobj.Status = 'Escalated';
                caseobj.Priority = 'High';
                if(CCWPOpenCaseQueueObj != Null) caseobj.OwnerId = CCWPOpenCaseQueueObj.Id; 
                update caseobj;
            }
        }
        System.debug('@@@@@@@@@@@@@@@@caseobj '+caseobj);
        result.success = true;
        return result;
      }
}