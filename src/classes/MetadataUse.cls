public with sharing class MetadataUse {     
    public static MetadataService.MetadataPort createService(){ 
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
    public void createObject(){
       MetadataService.CustomObject customeObject = new MetadataService.CustomObject();
       MetadataService.MetadataPort service = createService();
       customeObject.fullName = 'metadataObject__c';
       customeObject.label = 'Metadata Object';
       customeObject.pluralLabel = 'Metadata Objects';
       customeObject.nameField = new MetadataService.customField();
       customeObject.nameField.type_x = 'Text';
       customeObject.nameField.label = 'Sample Record';
       customeObject.deploymentStatus = 'Deployed';
       customeObject.sharingModel = 'ReadWrite';
       MetadataService.AsyncResult[] results = service.create(new List<MetadataService.Metadata>{customeObject});
   } 
}