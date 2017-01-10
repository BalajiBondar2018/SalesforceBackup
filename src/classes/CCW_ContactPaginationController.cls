public with sharing class CCW_ContactPaginationController {
 
    /*
    *   item in context from the page
    */
    public String contextItem{get;set;}
 
    /*
    *   set controller
    */
    private ApexPages.StandardSetController setCon;
 
    /*
    *   the contact ids selected by the user
    */
    private Set<Id> selectedContactIds;
 
    /*
    *   constructor
    */
    public CCW_ContactPaginationController ()
    {
        //init variable
        this.selectedContactIds= new Set<Id>();
 
        //gather data set
        this.setCon= new ApexPages.StandardSetController( [SELECT Id, FirstName, LastName, Title, Phone, Email FROM Contact] );
        this.setCon.setpageNumber(1);
        this.setCon.setPageSize(100);
 
    }
 
    /*
    *   handle item selected
    */
    public void doSelectItem(){
 
        this.selectedContactIds.add(this.contextItem);
 
    }
 
    /*
    *   handle item deselected
    */
    public void doDeselectItem(){
 
        this.selectedContactIds.remove(this.contextItem);
 
    }
 
    /*
    *   return count of selected items
    */
    public Integer getSelectedCount(){
 
        return this.selectedContactIds.size();
 
    }
 
    /*
    *   advance to next page
    */
    public void doNext(){
 
        if(this.setCon.getHasNext())
            this.setCon.next();
 
    }
 
    /*
    *   advance to previous page
    */
    public void doPrevious(){
 
        if(this.setCon.getHasPrevious())
            this.setCon.previous();
 
    }
 
    /*
    *   return current page of groups
    */
    public List<CCWRowItem> getContacts(){
 
        List<CCWRowItem> rows = new List<CCWRowItem>();
 
        for(sObject r : this.setCon.getRecords()){
            Contact c = (Contact)r;
 
            CCWRowItem row = new CCWRowItem(c,false);
            if(this.selectedContactIds.contains(c.Id)){
                row.IsSelected=true;
            }
            else{
                row.IsSelected=false;
            }
            rows.add(row);
        }
 
        return rows;
 
    }
 
    /*
    *   return whether previous page exists
    */
    public Boolean getHasPrevious(){
 
        return this.setCon.getHasPrevious();
 
    }
 
    /*
    *   return whether next page exists
    */
    public Boolean getHasNext(){
 
        return this.setCon.getHasNext();
 
    }
 
    /*
    *   return page number
    */
    public Integer getPageNumber(){
 
        return this.setCon.getPageNumber();
 
    }
 
    /*
    *    return total pages
    */
    Public Integer getTotalPages(){
 
        Decimal totalSize = this.setCon.getResultSize();
        Decimal pageSize = this.setCon.getPageSize();
 
        Decimal pages = totalSize/pageSize;
 
        return (Integer)pages.round(System.RoundingMode.CEILING);
    }
 
    /*
    *   helper class that represents a row
    */
    public with sharing class CCWRowItem{
 
        public Contact tContact{get;set;}
        public Boolean IsSelected{get;set;}
 
        public CCWRowItem(Contact c, Boolean s){
            this.tContact=c;
            this.IsSelected=s;
        }
 
    }
}