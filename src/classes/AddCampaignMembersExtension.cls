public class AddCampaignMembersExtension {
public List<Contact> contactList {get;set;}
public Campaign campaignObj {get;set;}
public blob contactblob{get;set;}
public boolean showContactListFlag{get;set;}

    public AddCampaignMembersExtension(ApexPages.StandardController controller) {
    getContactList();
    campaignObj = (Campaign) controller.getRecord();
    campaignObj = [select Id, Name from Campaign where Id=:campaignObj.Id LIMIT 1];
    showContactListFlag = false;
    }
    
    public List<Contact> getContactList(){
    contactList = [Select Account.Name, FirstName, LastName , Phone, Email from Contact where Account.Name !=NULL order by Account.Name LIMIT 25]; 
    return null; 
    }

    public Pagereference UploadBtnClick(){
    showContactListFlag = True;
    return null; 
    }


}