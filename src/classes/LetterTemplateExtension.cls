public class LetterTemplateExtension {
public string selectedTableType {get;set;}


public boolean tableNameInputTextFlag {get;set;}
public boolean selectObjectAndFieldsPBSectionFlag {get;set;}
public boolean tablePreviewPBSectionFlag{get;set;}


public List<String> optionList{get;set;}


    public LetterTemplateExtension(ApexPages.StandardController controller) {
        selectObjectAndFieldsPBSectionFlag = false;
        tablePreviewPBSectionFlag = false;
        
        optionList = new List<String>();
        optionList.add('Screen to allow end-user to select a Letter Template and then WMS will auto-populate . User will also select images necessary to send with letter. Then, WMS sends all letter text and images to output file');
        optionList.add('Screen to allow end-user to select a Letter Template and then WMS will auto-populate . User will also select images necessary to send with letter. Then, WMS sends all letter text and images to output file');
        optionList.add('Screen to allow end-user to select a Letter Template and then WMS will auto-populate . User will also select images necessary to send with letter. Then, WMS sends all letter text and images to output file.User will also select images necessary to send with letter. Then, WMS sends all letter text and images to output file.User will also select images necessary to send with letter. Then, WMS sends all letter text and images to output file');
        
    }
    
    public pagereference Next1BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate2Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Previous2BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate1Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Next2BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate3Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Previous3BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate2Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Next3BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate4Page');
    return pageRef;
    }
    
    public pagereference Previous4BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate3Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Next4BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate5Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Previous5BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate4Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Next5BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate6Page');
    pageRef.setRedirect(true);
    return pageRef;
    }
    
    public pagereference Previous6BtnClick(){
    PageReference pageRef = new PageReference('/apex/LetterTemplate5Page');
    return pageRef;
    }
    
    public pagereference TableTypeChange(){
        if(selectedTableType == 'CreateNew'){
            selectObjectAndFieldsPBSectionFlag = true;
            tablePreviewPBSectionFlag = false;
            tableNameInputTextFlag = true;
        }else{
            selectObjectAndFieldsPBSectionFlag = false;
            tablePreviewPBSectionFlag = true;
            tableNameInputTextFlag = false;
        }
    return null;
    }
    
    public pagereference TableFieldChange(){
        if(selectedTableType != 'Select'){
            tablePreviewPBSectionFlag = true;
        }
    return null;
    }
    
}