public class AgentLetterExtension {
public List<Attachment> attachmentList {get;set;}
    public AgentLetterExtension(ApexPages.StandardController controller) {
        attachmentList = new List<Attachment> ();
        attachmentList = [Select a.Name, a.Description, a.Owner.Name From Attachment a LIMIT 5];
    }
    
    public pagereference Next1BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter2Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Previous2BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter1Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Next2BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter3Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Previous3BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter2Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Next3BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter4Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Previous4BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter3Page');
    return pageRef;
    }
    
    public pagereference Next4BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter5Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Previous5BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter4Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Next5BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter6Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Previous6BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter5Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
       public pagereference Next6BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter7Page');
    pageRef.setredirect(true);
    return pageRef;
    }
    
    public pagereference Previous7BtnClick(){
    PageReference pageRef = new PageReference('/apex/AgentLetter6Page');
    pageRef.setredirect(true);
    return pageRef;
    }

}