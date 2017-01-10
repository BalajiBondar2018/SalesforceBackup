public class MyPagingController{
    public  List<Account> accountList = new List<Account>();
    public List<accountwrapper> accounts = new List<accountwrapper>(); 
    public List<accountwrapper> pageAccounts = new List<accountwrapper>();
    public Integer pageNumber;
    public Integer pageSize;
    public Integer totalPageNumber;
    public Integer getPageNumber(){
    return pageNumber;
    }
    public List<accountwrapper> getAccounts(){
    return pageAccounts;
    }
    public Integer getPageSize(){
    return pageSize;
    }
    public Boolean getPreviousButtonEnabled(){
    return !(pageNumber > 1);
    }
    public Boolean getNextButtonDisabled(){
    if (accounts == null) return true;
    else
    return ((pageNumber * pageSize) >= accounts.size());
    }
    public Integer getTotalPageNumber(){
    if (totalPageNumber == 0 && accounts !=null){
    totalPageNumber = accounts.size() / pageSize;
    Integer mod = accounts.size() - (totalPageNumber * pageSize);
    if (mod > 0)
    totalPageNumber++;
    }
    return totalPageNumber;
    }
    public MyPagingController(){
    pageNumber = 0;
    totalPageNumber = 0;
    pageSize = 10;
    ViewData();
    }
    public PageReference ViewData(){
    //accounts = null;
    totalPageNumber = 0;
    BindData(1);
    return null;
    }
    private void BindData(Integer newPageIndex){
    try{
    //string sortFullExp = sortExpression  + ' ' + sortDirection;
    //if (accounts == null)
    //accountList = Database.query('Select id, Name, BillingCity, BillingCountry, Phone, Fax, Website,(select Id, Name, Phone from Contacts) from Account order by ' + sortFullExp + ' limit 100');
    
    system.debug('@@@@@@accountList '+accountList);
    system.debug('@@@@@@accountList.size() '+accountList.size());
    for(Account acc :[Select id, Name, BillingCity, BillingCountry, Phone, Fax, Website,(select Id, LastName, Phone from Contacts) from Account LIMIT 100]){
    system.debug('@@@@@@acc '+acc );
    system.debug('@@@@@@acc.contacts'+acc.contacts);
    List<Contact> contactList = acc.contacts;
    accountwrapper aw = new accountwrapper(acc, contactList);
    system.debug('@@@@@@aw'+aw);
    
    accounts.add(aw);
    system.debug('@@@@@@accounts'+accounts);
    }
    //system.debug('@@@@@@accounts '+accounts);
    pageAccounts = new List<accountwrapper>{};
    Transient Integer counter = 0;
    Transient Integer min = 0;
    Transient Integer max = 0;
    if (newPageIndex > pageNumber){
    min = pageNumber * pageSize;
    max = newPageIndex * pageSize;
    }
    else{
    max = newPageIndex * pageSize;
    min = max - pageSize;
    }
    for(accountwrapper a : accounts){
    counter++;
    if (counter > min && counter <= max)
    pageAccounts.add(a);
    }
    pageNumber = newPageIndex;
    if (pageAccounts == null || pageAccounts.size() <= 0)
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Data not available for this view.'));
    }
    catch(Exception ex){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
    }
    }
    public PageReference nextBtnClick() {
    BindData(pageNumber + 1);
    return null;
    }
    public PageReference previousBtnClick() {
    BindData(pageNumber - 1);
    return null;
    }
    
    public class accountwrapper{
    public Account account{get;set;}
    public List<Contact> contactList{get;set;}
        public accountwrapper(Account a, List<Contact> conList){
            account= a;
            contactList = conList;
        }
    }
    
    }