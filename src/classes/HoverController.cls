public class HoverController {
    public List<ACCOUNT> getAccounts()   
    {   
        List<ACCOUNT> accounttList = new List<ACCOUNT>();   
        accounttList = [Select Id, Name from Account LIMIT 10];   
        return accounttList ;   
    }   
  
}