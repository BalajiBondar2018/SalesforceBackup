public class ConsumerPIIExtension {
    public List<Consumer_PII__c> consumerPIIList {get;set;}
    public Consumer_PII__c consumerPIIObj = new  Consumer_PII__c();
    
    public  Consumer_PII__c getconsumerPIIObj(){
        return consumerPIIObj;
    }
    


    public ConsumerPIIExtension(ApexPages.StandardController controller) {
    consumerPIIList =[select Id, Id_Type__c, Detailed_Id_Type__c , Id_Value__c from Consumer_PII__c LIMIT 5];
    }

}