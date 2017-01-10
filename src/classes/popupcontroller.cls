public class popupcontroller {
    public List<Account> accountList {get;set;}
    public boolean displayPopup {get; set;}     
    
    public List<Account> getAccount(){
    accountList =[select Id, Name, Phone, AccountNumber, Fax,Industry  from Account LIMIT 5];
    return accountList;
    }
    
    public Pagereference QuickSaveBtnClick(){
    update accountList ;
    return null;
    }
    
    public void closePopup() {        
       update accountList ;
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    
  }