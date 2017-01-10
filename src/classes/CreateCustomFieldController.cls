public with sharing class CreateCustomFieldController {
Public String selectedFieldType {get;set;}
Public String selectedDefaultValue {get;set;}
public String sessionId {get;set;}
Public List<MetadataServiceHelper.CustomObjectWrapper> CustomObjectWrapperList =  new List <MetadataServiceHelper.CustomObjectWrapper>();
Public MetadataServiceHelper.CustomFieldWrapper newCustomObjectWrapperObj {get;set;} 
Public List<MetadataServiceHelper.CustomFieldWrapper> CustomFieldWrapperList {get;set;} 
public String selectedobject{get;set;}
//show/hide pageblock sections
Public boolean showSalesforceEnvPBFlag {get;set;} 
Public boolean showSelectOperationPBFlag {get;set;} 
Public boolean showCustomObjectPBFlag {get;set;} 
Public boolean showCustomFieldPBFlag {get;set;}
Public boolean showResultPBFlag {get;set;}

//new Custom object properties 
Public String customobjectfullName {get;set;}
Public String customobjectlabel {get;set;}
Public String customobjectpluralLabel {get;set;}
Public String customobjectnameFieldtype {get;set;}
Public String customobjectnameFieldlabel {get;set;}
Public String customobjectsharingModel {get;set;}

//new Custom field properties  
Public String customfieldFullName {get;set;} 
Public String customfieldlabel {get;set;}
Public String customfieldtype {get;set;}
Public Integer customfieldlength {get;set;}
Public String customfielddefaultvalue {get;set;}

//-----------------------------------------Constructor---------------------------------------------------------------------------------- 
    public CreateCustomFieldController(){
        CustomFieldWrapperList  = new List<MetadataServiceHelper.CustomFieldWrapper> ();
        //MetadataServiceHelper.CustomFieldWrapper CustomFieldWrapperObj1 = new MetadataServiceHelper.CustomFieldWrapper('','','Text',50,'False');
        
        //CustomFieldWrapperList.add(CustomFieldWrapperObj1);
        sessionId = getSessionId();
        
        showSalesforceEnvPBFlag = true;
        showSelectOperationPBFlag = false; 
        showCustomObjectPBFlag = false;
        showCustomFieldPBFlag = false; 
        showResultPBFlag = false;
    }
    

//-----------------------------------------Properties----------------------------------------------------------------------------------    
    public List<MetadataServiceHelper.CustomFieldWrapper> getCustomFieldWrapperList(){
        return CustomFieldWrapperList;
    }    
    
    public void setCustomFieldWrapperList(List<MetadataServiceHelper.CustomFieldWrapper> CustomFieldWrapperList){
        this.CustomFieldWrapperList = CustomFieldWrapperList;
    } 
    
    
     public List<MetadataServiceHelper.CustomObjectWrapper> getCustomObjectWrapperList(){
        return CustomObjectWrapperList;
    }    
    
    public void setCustomObjectWrapperList(List<MetadataServiceHelper.CustomObjectWrapper> CustomObjectWrapperList){
        this.CustomObjectWrapperList = CustomObjectWrapperList;
    } 
       
//-----------------------------------------Action Methods------------------------------------------------------------------------------    
    public pagereference BackToHomeLinkClick(){
        showSalesforceEnvPBFlag = true;
        showSelectOperationPBFlag = false; 
        showCustomObjectPBFlag = false;
        showCustomFieldPBFlag = false;
        showResultPBFlag = false;
    return null;
    }
    
    
    Public pagereference CreateCustomFieldBtnClick(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        //service.SessionHeader.sessionId = UserInfo.getSessionId();
        service.SessionHeader.sessionId = sessionId;
        
        /*
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = 'Exam__c.TestField1__c';
        customField.label = 'Test Field1';
        customField.type_x = 'Text';
        customField.length = 42;

        MetadataService.AsyncResult[] results = service.create(new List<MetadataService.Metadata> { customField });
        System.debug('@@@@@@@@@@@@@@@results  '+results);
        */ 
        
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = selectedobject +'__c.'+customfieldFullName+'__c';
        customField.label = customfieldlabel;
        customField.type_x = customfieldtype;
        customField.length = customfieldlength;

        MetadataService.AsyncResult[] results = service.create(new List<MetadataService.Metadata> { customField });
        System.debug('@@@@@@@@@@@@@@@results  '+results);

        
        showSalesforceEnvPBFlag = false;
        showSelectOperationPBFlag = false; 
        showCustomObjectPBFlag = false;
        showCustomFieldPBFlag = false;
        showResultPBFlag = true; 
    return null;
    }
    
    Public pagereference CreateCustomObjectBtnClick(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        //service.SessionHeader.sessionId = UserInfo.getSessionId();
        service.SessionHeader.sessionId = sessionId;
       
        MetadataService.CustomObject customObject = new MetadataService.CustomObject();
        customObject.fullName = customobjectfullName +'__c';
        customObject.label = customobjectlabel;
        customObject.pluralLabel = customobjectpluralLabel;
        customObject.nameField = new MetadataService.CustomField();
        customObject.nameField.type_x = customobjectnameFieldtype;
        customObject.nameField.label = customobjectnameFieldlabel;
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = customobjectsharingModel;
        MetadataService.AsyncResult[] results = service.create(new List<MetadataService.Metadata> { customObject });
        
        System.debug('@@@@@@@@@@@@@@@results  '+results);
        showSalesforceEnvPBFlag = false;
        showSelectOperationPBFlag = false; 
        showCustomObjectPBFlag = false;
        showCustomFieldPBFlag = false;
        showResultPBFlag = true; 
    return null;
    }
    
    
    public String getSessionId(){
        sessionId = UserInfo.getSessionId();
        return sessionId;
    }
    
      public List<SelectOption> getName(){
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();     
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('selectobject','--Select--'));
        for(Schema.SObjectType f : gd){
           options.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getLabel()));
        }
        return options;
       }
    
    public Pagereference SelectOrgNextBtnClick(){
        showSalesforceEnvPBFlag = false;
        showSelectOperationPBFlag = true; 
        showCustomObjectPBFlag = false;
        showCustomFieldPBFlag = false; 
        showResultPBFlag = false;
    return null;
    }
    
     
    public Pagereference SelectOperationNextBtnClick(){
        showSalesforceEnvPBFlag = false;
        showSelectOperationPBFlag = false; 
        showCustomObjectPBFlag = true;
        showCustomFieldPBFlag = true;
        showResultPBFlag = false;
    return null;
    }
}