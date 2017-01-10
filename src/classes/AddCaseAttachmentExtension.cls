public class AddCaseAttachmentExtension {
public Case_Attachment__c caseAttachmentObj {get;set;}
  
    
     public String selectedType {get;set;}
    public Boolean selectedAwesomeness {get;set;}
    public String description {get;set;}
    public Case caseObj {get;set;} 
    public String fileName {get;set;}
    public Blob fileBody {get;set;}
     public AddCaseAttachmentExtension(ApexPages.StandardController controller) {
         //this.caseObj = (case)controller.getRecord();
    } 
   
    // creates a new caseObj_Attachment__c record
    private Database.SaveResult saveCustomAttachment() {
        case_Attachment__c obj = new case_Attachment__c();
        obj.case__c = caseObj.Id; 
        obj.description__c = description;
        obj.type__c = selectedType;
        //obj.awesome__c = selectedAwesomeness;
        // fill out cust obj fields
        return Database.insert(obj);
    }
    
    // create an actual Attachment record with the caseObj_Attachment__c as parent
    private Database.SaveResult saveStandardAttachment(Id parentId) {
        Database.SaveResult result;
        
        Attachment attachment = new Attachment();
        attachment.body = this.fileBody;
        attachment.name = this.fileName;
        attachment.parentId = parentId;
        // inser the attahcment
        result = Database.insert(attachment);
        // reset the file for the view state
        fileBody = Blob.valueOf(' ');
        return result;
    }
    
    /**
    * Upload process is:
    *  1. Insert new caseObj_Attachment__c record
    *  2. Insert new Attachment with the new caseObj_Attachment__c record as parent
    *  3. Update the caseObj_Attachment__c record with the ID of the new Attachment
    **/
    public PageReference processUpload() {
        try {
            Database.SaveResult customAttachmentResult = saveCustomAttachment();
        
            if (customAttachmentResult == null || !customAttachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));
                return null;
            }
        
            Database.SaveResult attachmentResult = saveStandardAttachment(customAttachmentResult.getId());
        
            if (attachmentResult == null || !attachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));            
                return null;
            } else {
                // update the custom attachment record with some attachment info
                case_Attachment__c customAttachment = [select id from case_Attachment__c where id = :customAttachmentResult.getId()];

                //customAttachment.Attachment__c = attachmentResult.getId();
                update customAttachment;
            }
        
        } catch (Exception e) {
            ApexPages.AddMessages(e);
            return null;
        }
        
        return new PageReference('/'+caseObj.Id);
    }
    
    public PageReference back() {
        return new PageReference('/'+caseObj.Id);
    }     

}