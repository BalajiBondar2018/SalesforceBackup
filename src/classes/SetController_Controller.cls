public class SetController_Controller {
    Public Integer size{get;set;}
    Public Integer noOfRecords{get; set;} 
    public List<ContactWrapper> contactWrapperList;
    public Map<Id,ContactWrapper> contactIdContactWrapperMap = new Map<Id,ContactWrapper>();
    public Map<Id,Boolean> contactIdSelectedStatusMap = new Map<Id,Boolean>();
    List<Contact> selectedContactList = (List<Contact>) setCon.getSelected();
    
    
    // ApexPages.StandardSetController must be instantiated    // for standard list controllers    
        public ApexPages.StandardSetController setCon {
        get {
            
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id, FirstName, LastName, CreatedBy.Name, LastModifiedBy.Name,HasOptedOutOfEmail,HomePhone FROM Contact LIMIT 10000]));
            }
            setCon.setPageSize(300);
            noOfRecords = setCon.getResultSize();
            return setCon;
        }
        set;
    }

    
    public pagereference UpdateSelectedContactOnChange(){
    System.debug('@@@@@@@@@@@@@UpdateSelectedContactOnChange ');
    Id conId = ApexPages.currentPage().getParameters().get('ContactId');
    contactIdSelectedStatusMap.put(conId , true);
    System.debug('@@@@@@@@UpdateSelectedContactOnChange/contactIdSelectedStatusMap'+contactIdSelectedStatusMap);
    return null;
    
    }
    
    
    // Initialize setCon and return a list of records  
        public List<ContactWrapper> getContactWrapperList() {
           contactWrapperList = new List<ContactWrapper>();
           for(Contact con : (List<Contact>)setCon.getRecords()){
                if(contactIdContactWrapperMap.containskey(con.Id))
                    contactWrapperList.add(new ContactWrapper(con, true));
                else
                    contactWrapperList.add(new ContactWrapper(con, false));
            }
                                    
            System.debug('@@@@@@@@@@@@@@@@@After'+contactWrapperList);
            System.debug('@@@@@@@@@@@@@@@@@ getContactWrapperList/contactIdContactWrapperMap '+contactIdContactWrapperMap);
            return contactWrapperList;
        }
    
       public Pagereference SaveBtnClick(){
       getContactWrapperList();
       System.debug('@@@@@@@@@@@@@@@@@save/contactWrapperList'+contactWrapperList);
       setCon.save(); 
       return null;
       }
           
            public Boolean hasNext { 
                get {
                    return setCon.getHasNext();
                }
                set;
                }     
                
              public Boolean hasPrevious {
              get {
              return setCon.getHasPrevious();
              }
              set;
              }        
              
              public Integer pageNumber {
              get {
              return setCon.getPageNumber();
              }         
              set;
              }        
             
             public void first() {
              setCon.first();
              }
              
              public void last() {
              setCon.last();
              }        
              
              public void previous() {
              setCon.previous();
              }        
              
              public void next() {
              setCon.next();
              }    

             
             public void UpdateCurrentPageSelection(){
                 for(contactWrapper conWrapper : contactWrapperList){
                      if(contactIdSelectedStatusMap.containskey(conWrapper.con.Id) && contactIdSelectedStatusMap.get(conWrapper.con.Id) == true){
                      conWrapper.selected = true; 
                      }
                  }
             }
             
            public class ContactWrapper{
            public Contact con {get; set;}
            public Boolean selected {get; set;}
            
            public ContactWrapper(Contact c , Boolean f) {
            con = c;
            selected = f;
            }
            }
                
}