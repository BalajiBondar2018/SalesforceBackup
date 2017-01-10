public class OpportunityTriggerHandler {
    public static void handleAfterInsert(List<Opportunity> newOpportunityList) {
    // handler logic
    System.debug('###handleAfterInsert');
    }
    public static void handleAfterDelete(List<Opportunity> newOpportunityList){
    // handler logic
    System.debug('###handleAfterDelete');
    }
    public static void handleAfterUpdate(List<Opportunity> newOpportunityList , List<Opportunity> oldOpportunityList){
    // handler logic
    System.debug('###handleAfterUpdate');
    }
}