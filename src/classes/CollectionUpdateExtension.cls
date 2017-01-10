public class CollectionUpdateExtension {
public Collection__c collectionObj {get;set;}
public List<Contact> contactList {get;set;}
public List<Collection_Note__c> collectionNoteList {get;set;}
public Collection_Note__c collectionNoteObj {get;set;}


    public CollectionUpdateExtension(ApexPages.StandardController controller) {

        collectionObj = [select Id,OfficeDepot__Bankrupatcy_File_Date__c, OfficeDepot__Check_Amount__c, OfficeDepot__Check_Date__c, OfficeDepot__Check__c, OfficeDepot__Close_Reason__c,OfficeDepot__Fwd_Agency__c,OfficeDepot__Fwd_Date__c,OfficeDepot__Image_Flag__c,OfficeDepot__SUBSCRIBER_ID__c,OfficeDepot__SUBSCRIBER_NAME__c from Collection__c LIMIT 1];
        
        contactList = [Select c.OfficeDepot__Phone_Value_2__c, c.OfficeDepot__Phone_Value_1__c, c.OfficeDepot__Phone_Type_2__c, 
                c.OfficeDepot__Phone_Type_1__c, c.OfficeDepot__Id_Value_4__c, c.OfficeDepot__Id_Value_3__c, 
                c.OfficeDepot__Id_Value_2__c, c.OfficeDepot__Id_Value_1__c, c.OfficeDepot__Id_Type_4__c, 
                c.OfficeDepot__Id_Type_3__c, c.OfficeDepot__Id_Type_2__c, c.OfficeDepot__Id_Type_1__c, 
                c.OfficeDepot__Furnisher_Name__c, c.OfficeDepot__Detailed_Id_Type_4__c, c.OfficeDepot__Detailed_Id_Type_3__c, 
                c.OfficeDepot__Detailed_Id_Type_2__c, c.OfficeDepot__Detailed_Id_Type_1__c, c.MailingStreet, c.MailingStateCode, 
                c.MailingState, c.MailingPostalCode, c.MailingCountryCode, c.MailingCountry, c.MailingCity, c.LastName, c.FirstName,
                c.Email From Contact c  Limit 2];
        collectionNoteList = [select Id, Owner.Name, Note__c, CreatedDate from Collection_Note__c LIMIT 10];        
        
    }

}