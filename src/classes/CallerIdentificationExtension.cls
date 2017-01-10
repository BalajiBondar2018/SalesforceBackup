public class CallerIdentificationExtension {
public Case caseObj = new Case();
public Contact contactObj = new Contact();
public boolean showContactSectionFlag {get;set;}
public string selectedContactId{get;set;}
public Id caseId;
public List<Contact> customerContactList = new List<Contact>();
public List<Account> accountList = new List<Account>();

    public Case getcaseObj (){
    if(caseId != Null){
    caseObj = [select Id, CaseNumber, accountId, Account.Name from Case where Id=:caseId];
    
    customerContactList = [select id, FirstName, LastName, Name, Title, email, Phone from Contact where accountId =:caseObj.accountId order by CreatedDate desc LIMIT 10];
    }        
    return caseObj ;
    }
    
    
    public void setcaseObj (Case caseObj ){
    this.caseObj = caseObj ;
    }
    
    public Id getcaseId(){
    return caseId ;
    }
    
    
    public void setcaseId(Id caseId){
    this.caseId  = caseId ;
    }


    public Contact getcontactObj(){
    return contactObj;
    }
    
    
    public void setcontactObj(Contact contactObj){
    this.contactObj  = contactObj;
    }
    
    
    public void setcustomerContactList(List<Contact> customerContactList){
        this.customerContactList = customerContactList ;
    }
    

    //------------------------------------accountList---------------------------------
    public List<Account> getaccountList(){
        accountList = [select Id,Name, Matching_Criteria__c ,OfficeDepot__Customer_ID__c, AccountNumber from Account where Matching_Criteria__c != Null LIMIT 10];
        return accountList;
    }
     

    public CallerIdentificationExtension(ApexPages.StandardController controller) {
        showContactSectionFlag = False;
        caseId= Apexpages.currentPage().getParameters().get('updateCaseId');
    }
    
    public pagereference SelectContactPersonClick(){
    System.debug('@@@SelectContactPersonClick called.');
    System.debug('@@@selectedContactId '+selectedContactId);
    if(selectedContactId == 'CreateNewContact'){
    showContactSectionFlag = True;
    }
    else{
    showContactSectionFlag = False;
    }
    return null;
    }
    
    public pagereference CreateContactClick(){
    
    System.debug('@@@CreateContactClick called.');
    System.debug('@@@contactObj' +contactObj);
    contactObj.accountId = caseObj.accountId;
    insert contactObj;
    
    showContactSectionFlag = false;
    selectedContactId = contactObj.Id;
    
    return null;    
    }
    
    public pagereference CancelClick(){
    contactObj = null;
    return null;
    }
    
    
    public List<SelectOption> getCustomerContactOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select','--Select--'));
        
        System.debug('@@@@@@@@@@getCustomerContactOptions customerContactList '+customerContactList );
        
        for(Contact contactObj : customerContactList){
        options.add(new SelectOption(contactObj.Id,contactObj.Name));
        }
        
        options.add(new SelectOption('CreateNewContact','--Create New Contact--'));




        return options;
    }
    
    //-----------------------------------------------------------------------
    public List<PieWedgeData> getPieData() 
    {  
        List<PieWedgeData> data = new List<PieWedgeData>();
        List<Account> accountObj = new List<Account>();  
        
        String sql = 'SELECT Name,OfficeDepot__Active_FCPs__c from Account where OfficeDepot__Active_FCPs__c != 0 LIMIT 10';
        accountObj = Database.Query(sql);
                   
            //data.add(new PieWedgeData(temp.Name,temp.OfficeDepot__Active_FCPs__c));
            data.add(new PieWedgeData('BAMS',150));
            data.add(new PieWedgeData('Wells Fargo',126));
            data.add(new PieWedgeData('Payezzy',97));
            data.add(new PieWedgeData('DollerDays',135));
            
        return data;  
    }  
    
    // Wrapper class  
    public class PieWedgeData 
    {  
        public String name { get; set; }  
        public Decimal data { get; set; }  
        
        public PieWedgeData(String name, Decimal data) 
        {  
            this.name = name;  
            this.data = data;  
        }  
    }  
    
     // Return a list of data points for a chart
    public List<Data> getData() {
        return CallerIdentificationExtension.getChartData();
    }
    
    // Make the chart data available via JavaScript remoting
    @RemoteAction
    public static List<Data> getRemoteData() {
        return CallerIdentificationExtension.getChartData();
    }

    // The actual chart data; needs to be static to be
    // called by a @RemoteAction method
    public static List<Data> getChartData() {
        List<Data> data = new List<Data>();
        data.add(new Data('Jan', 30, 90, 55));
        data.add(new Data('Feb', 44, 15, 65));
        data.add(new Data('Mar', 25, 32, 75));
        data.add(new Data('Apr', 74, 28, 85));
        data.add(new Data('May', 65, 51, 95));
        data.add(new Data('Jun', 33, 45, 99));
        data.add(new Data('Jul', 92, 82, 30));
        data.add(new Data('Aug', 87, 73, 45));
        data.add(new Data('Sep', 34, 65, 55));
        data.add(new Data('Oct', 78, 66, 56));
        data.add(new Data('Nov', 80, 67, 53));
        data.add(new Data('Dec', 17, 70, 70));
        return data;
    }
    
    // Wrapper class
    public class Data {
        public String name { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        public Integer data3 { get; set; }
        public Data(String name, Integer data1, Integer data2, Integer data3) {
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;
        }
    }
    
}