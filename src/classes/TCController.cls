public class TCController {
Public String TermAndConditionBody {get;set;}

    public PageReference ShowTCClick() {
        List<Attachment> attachmentObj = [Select Id, Body,ParentId from Attachment where ParentId ='0019000000CHxEE' LIMIT 1];
        TermAndConditionBody  = EncodingUtil.base64Encode(attachmentObj[0].Body);
        return null;
    }




}