public class SupportInformationExtension {

    public Case CaseObj = new Case();
    
    public Case getCaseObj (){
    CaseObj = [select Id,OfficeDepot__Rating_Graphics__c,Priority_Graphics__c, OwnerId from Case where Id='50090000000ljVM'];
    return CaseObj ;
    }
    
    public void setCaseObj (Case CaseObj){
    this.CaseObj = CaseObj ;
    }





public List<OfficeDepot__CustomerRating__c> CustomerRatingList = new List<OfficeDepot__CustomerRating__c>();

public List<OfficeDepot__CustomerRating__c> getCustomerRatingList() {
 CustomerRatingList = [select Id,OfficeDepot__Question__c,OfficeDepot__Comment__c,OfficeDepot__very_good__c,OfficeDepot__good__c,OfficeDepot__bad__c from OfficeDepot__CustomerRating__c];
return CustomerRatingList;
}
    public SupportInformationExtension(ApexPages.StandardController controller) {

    }

}