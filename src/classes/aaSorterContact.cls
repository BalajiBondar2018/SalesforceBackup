public class aaSorterContact {
    private String sortedBy = null;
    private Boolean sortAscending = null;
    private AP_SortHelper sorter = new AP_SortHelper();
    private List<Account> sortedList = null;
    
    public aaSorterContact() {
        sorter.originalList = [SELECT Name, Phone FROM Account LIMIT 1000];
    }
    public PageReference SortByName() {
        setSortedBy('NAME');
        sortedList = (List<Account>) sorter.getSortedList('Name', sortAscending);
        return null;
    }

    public PageReference SortByPhone() {
        setSortedBy('PHONE');
        sortedList = (List<Account>) sorter.getSortedList('Phone', sortAscending);
        return null;
    }
    public List<Account> getList() {
        if (sortedList == null) {
            SortByName();
        }
        return sortedList;
    }
    private void setSortedBy(String value) {
        if (sortedBy == value) {
             sortAscending = !sortAscending;
        } else {
            sortAscending = true;
        }
        sortedBy = value;
    }
}