public with sharing class PagingUsingSetController {
    //Variable decleration
    public List<AccountWrapper> AccountWrapperList;
    public Map<Id,AccountWrapper> SelectedAccountWrapperMap;
    
 
    //Class Constructor
    public PagingUsingSetController(){
    SelectedAccountWrapperMap = new  Map<Id,AccountWrapper>();
    }
    
    // instantiate the StandardSetController from a query locator
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                string querystring = 'select  Id, Name , Phone ,Owner.Name FROM Account order by ' + sortField + '  ' + sortDir;
                System.debug('@@@@@@@@@@querystring  '+querystring );
                con = new ApexPages.StandardSetController(Database.getQueryLocator(querystring));
                // sets the number of records in each page set
                con.setPageSize(10);
            }
            return con;
        }
        set;
    }
    
    
    public void setSelectedAccountWrapperMap(){
        for (AccountWrapper accountWrapperObj : AccountWrapperList) {
            if(SelectedAccountWrapperMap.containsKey(accountWrapperObj.acc.Id)){
                if (!accountWrapperObj.checked)
                    SelectedAccountWrapperMap.remove(accountWrapperObj.acc.Id);
            }
            else{
                if (accountWrapperObj.checked)
                    SelectedAccountWrapperMap.put(accountWrapperObj.acc.Id,accountWrapperObj);
            }   
        }
    }


    public pagereference TestAction(){  
setSelectedAccountWrapperMap();
return null;
    }

    
       public List<AccountWrapper> getSelectedAccountWrapperMap(List<AccountWrapper> AccountWrapperList ){
        for(AccountWrapper accountWrapperObj : AccountWrapperList){
            if(SelectedAccountWrapperMap.containsKey(accountWrapperObj.acc.Id))
                accountWrapperObj.checked=true;
                
        }
        return AccountWrapperList;
    }
    
 
    // returns a list of wrapper objects for the sObjects in the current page set
    public List<AccountWrapper> getAccountWrapperList () {
        System.debug('@@@@@@@@@@@ getAccountWrapperList'); 
        AccountWrapperList = new List<AccountWrapper>();
        for (Account accountObj : (List<Account>)con.getRecords())
            AccountWrapperList.add(new AccountWrapper(accountObj));
            
        getSelectedAccountWrapperList(AccountWrapperList);
        System.debug('@@@@@@@@@@@AccountWrapperList.size()'+AccountWrapperList.size()); 
        return AccountWrapperList;
    }
 
    public List<AccountWrapper> getSelectedAccountWrapperList(List<AccountWrapper> AccountWrapperList)
    {
    
        for(AccountWrapper accountWrapperObj : AccountWrapperList){
            if(SelectedAccountWrapperMap.containsKey(accountWrapperObj.acc.Id))
                accountWrapperObj.checked=true;
        }
    
        return AccountWrapperList;
    } 
 
//----------------------Action Methods-------------------------------------------------------------------
   // returns the PageReference of the original page, if known, or the home page.
    public void cancel() {
    con.cancel();
    }    

//----------------------Paging Methods------------------------------------------------------------------- 
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
 
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
 
    // returns the first page of records
    public void first() {
        con.first();
    }
 
    // returns the last page of records
    public void last() {
        con.last();
    }
 
    // returns the previous page of records
    public void previous() {
        con.previous();
        setSelectedAccountWrapperMap();
    }

    // returns the next page of records
    public void next() {
        con.next();
        setSelectedAccountWrapperMap();
    }



//---------------------------------------Sorting Methods----------------------------------------------
    //the current sort direction. defaults to asc
    public String sortDir {
           get  { if (sortDir == null) {  sortDir = 'desc'; } return sortDir;  }
           set;
    } 
    //the current field to sort by. defaults to Name
    public String sortField {
      get  { if (sortField == null) {sortField = 'Name'; } return sortField;  }
      set;
    }
        //toggles the sorting of query from asc<-->desc
        public void toggleSort() {
        System.debug('@@@@@@@toggleSort called.');
        //toggle the sorting direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        //run the query again
        SortAccountWrapperList();
        }
        //Sort the FCP list based on the column selected and direction
    private void SortAccountWrapperList() { 
        System.debug('@@@@SortAccountWrapperList called.');
        try {
            list<Account> tempAccountList = new list<Account>();
            // sorting the FCP list
        System.debug('@@@@SortAccountWrapperList called/AccountWrapperList.size().'+AccountWrapperList.size());   
        for(integer count=0; count< AccountWrapperList.size(); count++){
             tempAccountList.add(AccountWrapperList[count].acc);
        } 
        System.debug('@@@@tempAccountList'+tempAccountList);   
        AccountWrapperList.clear();          
        sortList(tempAccountList ,sortField, sortDir);      
        //Itrating FCP list and binding it with FCP Wrapper list which is shown on the UI.
        for(Account AccountObj : tempAccountList){
            AccountWrapper AccountWrapperObj = new AccountWrapper(AccountObj);            
            AccountWrapperObj.checked= SelectedAccountWrapperMap.get(AccountObj.Id).checked;
            AccountWrapperList.add(AccountWrapperObj);
            }
        System.debug('@@@@@@@@@@@SortAccountWrapperList/AccountWrapperList'+AccountWrapperList);    
        tempAccountList.clear();
        
        } catch (Exception e) {
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.SortingErrorMessage));
        }
 }
//sort the list of FCPs localy in asc and desc order.   

    public static void sortList(List<Sobject> items, String sortField, String order){
    List<Sobject> resultList = new List<Sobject>();
    //Create a map that can be used for sorting 
    Map<object, List<Sobject>> objectMap = new Map<object, List<Sobject>>();
    for(Sobject ob : items){
                if(objectMap.get(ob.get(sortField)) == null){  // For non Sobject use obj.ProperyName
                    objectMap.put(ob.get(sortField), new List<Sobject>()); 
                }
                objectMap.get(ob.get(sortField)).add(ob);
        }       
        //Sort the keys
        List<object> keys = new List<object>(objectMap.keySet());
        keys.sort();
       
        for(object key : keys){ 
            resultList.addAll(objectMap.get(key)); 
        }
       
        //Apply the sorted values to the source list
        items.clear();
        if(order.toLowerCase() == 'asc'){
            for(Sobject ob : resultList){
                items.add(ob); 
            }
        }else if(order.toLowerCase() == 'desc'){
            for(integer i = resultList.size()-1; i >= 0; i--){
                items.add(resultList[i]);  
            }
        }
    }  






//----------------------Account Wrapper-------------------------------------------------------------------
    public class AccountWrapper {
        public Boolean checked{ get; set; }
        public Account acc { get; set;}
     
        public AccountWrapper(){
            acc = new Account();
            checked = false;
        }
     
        public AccountWrapper(Account c){
            acc = c;
            checked = false;
        }
    }
 
}