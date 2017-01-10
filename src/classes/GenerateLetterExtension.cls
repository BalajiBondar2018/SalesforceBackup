public class GenerateLetterExtension {
public string letterbodyStr;

public String getletterbodyStr(){
return letterbodyStr ;
}


public void setletterbodyStr(String letterbodyStr){
this.letterbodyStr = letterbodyStr ;
}


public string selectedLetter {get;set;}
public string selectedTCKSection {get;set;}

public boolean showFetchTCKInfoFlag {get;set;}
public boolean showUpdateLetterContentFlag {get;set;}

EmailTemplate emailtemplateObj = new EmailTemplate ();
public Case caseObj ;
public Map<Id,String> letterIdNameMap = new Map<Id,String>();
PageReference newocp ;

    public GenerateLetterExtension(ApexPages.StandardController controller) {
        caseObj = (case) controller.getRecord();
        caseObj = [select Id, CaseNumber from case where Id=:caseObj.Id LIMIT 1];
        System.debug('@@@@@@@@@@@@@caseObj  '+caseObj);
        
        emailtemplateObj = [Select  e.TemplateType, e.TemplateStyle, e.Subject, e.OwnerId, e.NamespacePrefix, e.Name, e.Markup,e.IsActive, e.Id, e.HtmlValue, e.FolderId, e.Encoding, e.DeveloperName, e.Description, e.BrandTemplateId, e.Body, e.ApiVersion From EmailTemplate e where e.name='Custom HTML Template'];
        //letterbodyStr = emailtemplateObj.HTMLValue;
        //letterbodyStr = '';
        //caseobj = [select Id,CaseNumber, Owner.Name, OfficeDepot__Created_On__c  from Case LIMIT 1];
        /*
        letterbodyStr = '<html><body>4356789<br/>';
        letterbodyStr += '<table border="1"><tr><td>Test123</td><td>Test1</td><td>Test1</td></tr>';
        letterbodyStr += '<tr><td><img src="https://ap1.salesforce.com/servlet/servlet.ImageServer?id=01590000000q9Te&oid=00D900000000fqI" alt="banner" height="31" width="200"/></td><td>Test1</td><td>{!case.Id}</td></tr></table> ';
        letterbodyStr += '</body></html>'; 
        */
        //letterbodyStr = letterbodyStr.replace('{!Case.CaseNumber}', caseobj.CaseNumber);
        //letterbodyStr = letterbodyStr.replace('{!Case.Owner}', caseobj.Owner.Name);
        
        showFetchTCKInfoFlag = FALSE;
        showUpdateLetterContentFlag = FALSE;
        
         
           
    }
    
    
    public List<SelectOption> getLetters() {
        List<SelectOption> letters = new List<SelectOption>();
        letters.add(new SelectOption('select' , '--Select Letter--'));
        for(EmailTemplate emailtemplateObj : [Select e.TemplateType, e.TemplateStyle, e.Subject, e.OwnerId, e.NamespacePrefix, e.Name From EmailTemplate e where  e.TemplateType='custom' LIMIT 10]){
        letters.add(new SelectOption(emailtemplateObj.Id ,emailtemplateObj.Name));
        letterIdNameMap.put(emailtemplateObj.Id , emailtemplateObj.Name);
        }
        return letters ;
    }


    public pagereference FetchLetterContent(){
        System.debug('@@@@@@@@@@@selectedLetter  '+selectedLetter );
        System.debug(letterIdNameMap.get(selectedLetter));
        
        if(selectedLetter == 'select'){
            showFetchTCKInfoFlag = FALSE;
            showUpdateLetterContentFlag = FALSE;
        }
        else{
            showFetchTCKInfoFlag = TRUE;
            showUpdateLetterContentFlag = TRUE;
            
            //emailtemplateObj = [Select  e.TemplateType, e.TemplateStyle, e.Subject, e.OwnerId, e.NamespacePrefix, e.Name, e.Markup,e.IsActive, e.Id, e.HtmlValue, e.FolderId, e.Encoding, e.DeveloperName, e.Description, e.BrandTemplateId, e.Body, e.ApiVersion From EmailTemplate e where e.name='Custom HTML Template'];
            //selectedLetter ='Custom HTML Template';
            emailtemplateObj = [Select  e.TemplateType, e.TemplateStyle, e.Subject, e.OwnerId, e.NamespacePrefix, e.Name, e.Markup,e.IsActive, e.Id, e.HtmlValue, e.FolderId, e.Encoding, e.DeveloperName, e.Description, e.BrandTemplateId, e.Body, e.ApiVersion From EmailTemplate e 
                                      where e.Id=:selectedLetter];
            
            //-------------------------------------------------------replace case object dynamic values/no field mapping required----------------------------------
            Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Case.fields.getMap();
                    Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
                    Map<String,string> caseFieldValueMap = new Map<String,String>();
                    
                    
                    String commaSepratedFields = '';
                    List<String> commaSepratedFieldsList = new List<String>();
                    
                    for(OfficeDepot__Letter_Field_Mapping__c letterfieldmappingObj : [Select o.OfficeDepot__Value__c, o.OfficeDepot__Source__c, o.OfficeDepot__Letter__c, o.OfficeDepot__Active__c, o.OfficeDepot__API_Name__c, o.Name, o.Id From OfficeDepot__Letter_Field_Mapping__c o where o.OfficeDepot__Letter__r.Name=:letterIdNameMap.get(selectedLetter) and o.OfficeDepot__Active__c= TRUE and o.OfficeDepot__Source__c='case']){
                            if(commaSepratedFields == null || commaSepratedFields == ''){
                                    commaSepratedFields = letterfieldmappingObj.OfficeDepot__API_Name__c;
                                    commaSepratedFieldsList.add(letterfieldmappingObj.OfficeDepot__API_Name__c);
                            }else{
                                    commaSepratedFields = commaSepratedFields + ', ' + letterfieldmappingObj.OfficeDepot__API_Name__c;
                                    commaSepratedFieldsList.add(letterfieldmappingObj.OfficeDepot__API_Name__c);
                            }
                    }
                    
                    String query = 'select ' + commaSepratedFields + ' from case where Id=\''+ System.currentPageReference().getParameters().get('id') +'\' LIMIT 1';
                    System.debug('@@@@@@@query '+query);
                    
                    
                    List<Case> caseobjList = Database.query(query);
                    
                    for(String fieldName: commaSepratedFieldsList){
                         System.debug('@@@@@@@fieldName '+fieldName);
                         if(fieldName.contains('.')){
                                 List<String> fieldNameList  = fieldName.split('\\.');
                                 System.debug('@@@@@@@fieldNameList '+fieldNameList);
                                 
                                 if((String) caseobjList[0].getSObject(fieldNameList[0]).get(fieldNameList[1]) != Null){
                                                caseFieldValueMap.put(fieldName, (String) caseobjList[0].getSObject(fieldNameList[0]).get(fieldNameList[1]));           
                                }
                             }
                         else{
                                 if(String.valueOf(caseobjList[0].get(fieldName))!=Null)
                                        caseFieldValueMap.put(fieldName,  String.valueOf(caseobjList[0].get(fieldName)));
                         }
            }
            
            System.debug('@@@@@@@@caseFieldValueMap '+caseFieldValueMap);
            
            letterbodyStr = emailtemplateObj.HTMLValue;
            System.debug('@@@@@@@@letterbodyStr '+letterbodyStr);
            
            for(String fieldName: commaSepratedFieldsList){
                 String fieldNameTag = '{!workcase.'+ fieldName + '}';
                 
                 if(fieldName.contains('.')){
                     List<String> fieldNameList  = fieldName.split('\\.');
                     
                     if((String) caseobjList[0].getSObject(fieldNameList[0]).get(fieldNameList[1]) != Null){
                                caseFieldValueMap.put(fieldName, (String) caseobjList[0].getSObject(fieldNameList[0]).get(fieldNameList[1]));
                                letterbodyStr = letterbodyStr.replace(fieldNameTag , (String) caseobjList[0].getSObject(fieldNameList[0]).get(fieldNameList[1]));               
                        }
                 }
                 else{
                         if(String.valueOf(caseobjList[0].get(fieldName))!=Null)
                        letterbodyStr = letterbodyStr.replace(fieldNameTag , caseFieldValueMap.get(fieldName));
                 }
            }
            
            //---------------------------------------------------replace global values-----------------------------------------------------------------------------
            Map<String,string> globalFieldValueMap = new Map<String,String>();
            for(OfficeDepot__Letter_Field_Mapping__c letterfieldmappingObj : [Select o.OfficeDepot__Value__c, o.OfficeDepot__Source__c, o.OfficeDepot__Letter__c, o.OfficeDepot__Active__c, o.OfficeDepot__API_Name__c, o.Name, o.Id From OfficeDepot__Letter_Field_Mapping__c o where  o.OfficeDepot__Letter__r.Name=:letterIdNameMap.get(selectedLetter) and  o.OfficeDepot__Active__c= TRUE and o.OfficeDepot__Source__c='global']){
                    globalFieldValueMap.put(letterfieldmappingObj.Name , letterfieldmappingObj.OfficeDepot__Value__c);
            }
                    
            for(String fieldName: globalFieldValueMap.keyset()){
                         if(globalFieldValueMap.get(fieldName) != Null)
                            letterbodyStr = letterbodyStr.replace(fieldName , globalFieldValueMap.get(fieldName));
                            
            }
        
       }
    
    
    return null;
    } 


    public pagereference TCKSectionChange(){
    
    return null;
    }
    
    
    public pagereference OverwriteInformationBtnClick(){
     //--------------------------------------------------TCK Fields using webservice-----------------------------------------------------------------------
        Map<String,string> TCKFieldValueMap = new Map<String,String>();
        for(OfficeDepot__Letter_Field_Mapping__c letterfieldmappingObj : [Select o.OfficeDepot__Value__c, o.OfficeDepot__Source__c, o.OfficeDepot__Letter__c, o.OfficeDepot__Active__c, o.OfficeDepot__API_Name__c, o.Name, o.Id From OfficeDepot__Letter_Field_Mapping__c o where  o.OfficeDepot__Letter__r.Name=:letterIdNameMap.get(selectedLetter)  and o.OfficeDepot__Active__c= TRUE and o.OfficeDepot__Source__c='Telecheck']){
                TCKFieldValueMap.put(letterfieldmappingObj.Name , letterfieldmappingObj.OfficeDepot__Value__c);
        }
                
        for(String fieldName: TCKFieldValueMap.keyset()){
                     if(TCKFieldValueMap.get(fieldName) != Null)
                        letterbodyStr = letterbodyStr.replace(fieldName , TCKFieldValueMap.get(fieldName));
                        
        }
    return null;
    }
    
    
    
    public pagereference generateLetterPDFClick(){
    showUpdateLetterContentFlag = true;
    String p1Str = System.currentPageReference().getParameters().get('p1');
    System.debug('@@@@@@@@@@@p1Str '+p1Str);


    PageReference newocp = new PageReference('/apex/GenerateLetterPDFPage');
    //System.debug('@@@@@@@@letterbodyStr at pageref : '+letterbodyStr);
    newocp.getParameters().put('letterHTMLStr',letterbodyStr);
    //newocp.setRedirect(true);
    System.debug('@@@@@@@@@@@@@@newocp '+newocp);
    
    return newocp;  

  
    }
   
    public pagereference CancelClick(){
    letterbodyStr = '';
    selectedLetter = 'select';
    selectedTCKSection  = 'select';
    
    showFetchTCKInfoFlag = FALSE;
    showUpdateLetterContentFlag = FALSE;
            
    return null;
    } 
    
    public pagereference GenerateAndAttachClick(){
        System.debug('@@@@@@@@@@@@@@ GenerateAndAttachClick');
        System.debug('@@@@@@@@@@@@@@newocp '+newocp);
        System.debug('@@@@@@@@@@@@@@caseObj'+caseObj);
        
        OfficeDepot__Case_Attachment__c customattachmentObj = new OfficeDepot__Case_Attachment__c();
        customattachmentObj.Name = letterIdNameMap.get(selectedLetter);
        customattachmentObj.OfficeDepot__Case__c = System.currentPageReference().getParameters().get('id');
        customattachmentObj.OfficeDepot__Description__c = letterIdNameMap.get(selectedLetter);
        customattachmentObj.OfficeDepot__Type__c = 'TRS';
        insert customattachmentObj;
       
       
        //newocp = Page.GenerateLetterPDFPage;

        // add parent id to the parameters for standardcontroller
        //newocp.getParameters().put('letterHTMLbody',letterbodyStr);
        
        // create the new attachment
        Attachment attachment = new Attachment();
        attachment.contenttype = 'application/pdf';
        
        letterbodyStr = letterbodyStr.remove('<p>&nbsp;</p>');
        System.debug('@@@@@@@@letterbodyStr '+letterbodyStr);
        attachment.Body =  Blob.toPdf(letterbodyStr);
        attachment.Name = letterIdNameMap.get(selectedLetter) +'_'+ caseObj.CaseNumber +'.pdf';
        attachment.ParentId = customattachmentObj.Id; 
        insert attachment;
        
        PageReference customAttachmentpage = new PageReference('/' + customattachmentObj.Id);
        customAttachmentpage.setRedirect(true);
        return customAttachmentpage ;
       
    //return null;
    }
}