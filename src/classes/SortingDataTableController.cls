public class SortingDataTableController {
 public Contact[] getContacts() {
        return [select FirstName, LastName, Birthdate, Email, LastModifiedDate, OwnerId from Contact order by Name limit 500];
    }


}