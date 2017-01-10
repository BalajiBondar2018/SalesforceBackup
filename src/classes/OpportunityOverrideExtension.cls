public class OpportunityOverrideExtension {

    public OpportunityOverrideExtension(ApexPages.StandardController controller) {
    
    }
    public PageReference PageLoad(){
    Pagereference pageRef = new Pagereference ('/006/e');
    pageRef.getParameters().put('nooverride','1');
    pageRef.getParameters().put('opp3','TestOverride');
    pageRef.getParameters().put('accid',ApexPages.currentPage().getParameters().get('accid'));
    return pageRef ;
    }

}