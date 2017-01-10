public class AutoCompleteDemoController{
    public list<account> getAccountList(){
        return [select id,name from account limit 10];
    }
}