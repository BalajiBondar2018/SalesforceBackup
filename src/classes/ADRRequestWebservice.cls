//class update v 2.0
global class ADRRequestWebservice {
    webservice static List<ADR_Request__c> retrieveADRRequestList(Id accountId) {
        List<ADR_Request__c> ADRRequestList = new List<ADR_Request__c>();
        ADRRequestList =[select Id from ADR_Request__c where Account__c =:accountId];
        return ADRRequestList;
    }
}
