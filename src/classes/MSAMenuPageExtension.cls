public class MSAMenuPageExtension {
public Id caseId {get;set;}
    public MSAMenuPageExtension(ApexPages.StandardController controller) {
    caseId =  ApexPages.currentPage().getParameters().get('id');
    }




}