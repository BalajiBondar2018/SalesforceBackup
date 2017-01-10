public class CollectionUpdatePage1Controller {

public Collection__c collectionObj  = new Collection__c();
public Collection__c getCollection(){
collectionObj  = [select Id, OfficeDepot__Check__c, OfficeDepot__Check_Date__c, OfficeDepot__Fwd_Agency__c, OfficeDepot__Fwd_Date__c,OfficeDepot__SUBSCRIBER_NAME__c, OfficeDepot__SUBSCRIBER_Id__c,OfficeDepot__Reason_Code__c,OfficeDepot__Close_Reason__c from Collection__c LIMIT 1];
return collectionObj ;
}

}