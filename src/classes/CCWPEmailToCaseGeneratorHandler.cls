global class CCWPEmailToCaseGeneratorHandler implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
      //variable decleration
      Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
      Case caseobj = new Case();
      String subToCompare = 'CCWP';
      
      System.debug('@@@@@@@@@@@@@@@@CCWPEmailGeneratorHandler');  
      System.debug('@@@@@@@@@@@@@@@@email.plainTextBody '+email.plainTextBody);  
      System.debug('@@@@@@@@@@@@@@@@email.Subject'+email.Subject);
      System.debug('@@@@@@@@@@@@@@@@email.fromAddress'+email.fromAddress);
      System.debug('@@@@@@@@@@@@@@@@envelope.fromAddress'+envelope.fromAddress);
      
        if(email.subject.containsIgnoreCase(subToCompare)){
            Contact caseContact = [SELECT Id, Name, Email FROM Contact WHERE Email = :email.fromAddress LIMIT 1];
            System.debug('@@@@@@@@@@@@@@@@caseContact '+caseContact );
            
            Group CCWPOpenCaseQueueObj = [Select g.Name, g.Id From Group g where g.Name='CCWP Open Case Queue' LIMIT 1];
            System.debug('@@@@@@@@@@@@@@@@CCWPOpenCaseQueueObj '+CCWPOpenCaseQueueObj );
            
            caseobj.Subject = email.Subject;
            caseobj.description = email.plainTextBody;
            caseobj.Status = 'New';
            caseobj.Priority = 'Medium';
            caseobj.Origin = 'Email';
            caseobj.OfficeDepot__Rating__c ='2';
            //Assign Contact Id
            if(caseContact !=Null) caseobj.ContactId = caseContact.Id;
            
            //Populate case Queue Id
            if(CCWPOpenCaseQueueObj != Null) caseobj.OwnerId = CCWPOpenCaseQueueObj.Id; 
            
            insert caseobj;
                  
            //--------------------------------------Save any Binary Attachment-------------------------------------------
            for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
            Attachment attachment = new Attachment();

            attachment.Name = bAttachment.fileName;
            attachment.Body = bAttachment.body;
            attachment.ParentId = caseobj.Id;
            insert attachment;
            }
        }
        System.debug('@@@@@@@@@@@@@@@@caseobj '+caseobj);
        result.success = true;
        return result;
      }
}