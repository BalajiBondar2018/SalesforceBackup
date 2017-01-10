public class ConsumerSearchpage1Controller {
public Contact contactObj {get;set;}
public List<Contact> contactList;

public List<Contact> getcontactList(){
contactList = [select Id, FirstName, LastName from Contact Limit 10];
return contactList;
}




}