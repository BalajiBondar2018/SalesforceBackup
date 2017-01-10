public class manageSurchangeExtension {
//variable decleration
public string surchargestr{get;set;}
public Decimal surchargeper{get;set;}
public Map<String,String> existingSurchargeMap = new Map<String,String>();
public Decimal totalsurchargeper {get;set;}

public Account account = new Account();
public Account getaccount(){
return account;
}
public void setaccount(Account account){
        this.account = account;
}
//property to store the FCP wrapper records
public List<Surcharge__c> surchargeList = new List<Surcharge__c> ();
public List<Surcharge__c> getsurchargeList(){
    return surchargeList;
}
public void setsurchargeList(List<Surcharge__c> surchargeList){
    this.surchargeList = surchargeList;
}

//--------------------------------------------------Constructor----------------------------------------------------------------------
    public manageSurchangeExtension(ApexPages.StandardController controller) {
    account = (Account) controller.getRecord();
    
    	retrieveSurchargeList();
	
	    totalsurchargeper=0;
	    for(Surcharge__c scharge : surchargeList){
	        totalsurchargeper += scharge.Percentage__c;
	    }
    }

//---------------------------------------------------Action Methods------------------------------------------------------------------    
    //Back to Contract button click action
    public Pagereference BackBtnClick(){
        PageReference pageRef = new PageReference('/'+account.Id);  
        pageRef.setRedirect(true);
        return pageRef;
    }
    //Add new surcharge to the list
    public pagereference AddBtnClick(){
        totalsurchargeper=0;
        //surchargeper
        for(Surcharge__c scharge : surchargeList){
            totalsurchargeper += scharge.Percentage__c;
        }
        
        if(surchargestr == '' || surchargestr =='none'){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select surcharge.');
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        else if(surchargeper + totalsurchargeper > 100){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'surcharge total cannot be greater than 100%');
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        else if(surchargeper + totalsurchargeper >100){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'For newly added surcharge, % cannot be greater than '+(100-totalsurchargeper)+'.');
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        Surcharge__c surcharge = new Surcharge__c();
        surcharge.Surchange__c = surchargestr;
        surcharge.Percentage__c = surchargeper;
        surcharge.Account__c = account.Id;
        surcharge.Amount__c = (account.Total_Surcharge__c*surchargeper)/100; 
        insert surcharge;
        retrieveSurchargeList();
        surchargeper = null;
        return null;
    }
    //Delete surcharge from the existing surcharge list
    public pagereference DeleteBtnClick(){
        Id sId = Apexpages.currentPage().getParameters().get('surchargeId');
        
        for(Surcharge__c scharge : SurchargeList){
            if(sId == scharge.Id){
                delete scharge;
                break;
                }
        }
        retrieveSurchargeList();
        //surchargeper
        for(Surcharge__c scharge : surchargeList){
            totalsurchargeper += scharge.Percentage__c;
        }
        return null;
    }
    
    //Update surcharge from the existing surcharge list
    public pagereference UpdateBtnClick(){
         totalsurchargeper=0;
        //surchargeper
        for(Surcharge__c scharge : surchargeList){
            totalsurchargeper += scharge.Percentage__c;
        }
        
        if(surchargeper + totalsurchargeper >100){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'surcharge total cannot be greater than 100%');
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        Id sId = Apexpages.currentPage().getParameters().get('surchargeId');
        for(Surcharge__c scharge : SurchargeList){
            if(sId == scharge.Id){
                System.debug('@@@@@@@@@@@account.Total_Surcharge__c '+account.Total_Surcharge__c);
                System.debug('@@@@@@@@@@@surchargeper '+surchargeper);
                scharge.Amount__c = (account.Total_Surcharge__c*scharge.Percentage__c)/100; 
                update scharge;
                break;
            }
        }
        retrieveSurchargeList();
        return null;
    }

//----------------------------------------support methods--------------------------------------------------------------
    public List<SelectOption> Surcharges = new List<SelectOption>(); 
        public List<SelectOption> getSurcharges(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Surcharge__c.Surchange__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption('none','--None--'));        
            for( Schema.PicklistEntry f : ple){
                  if(!existingSurchargeMap.containskey(f.getValue()))
                  options.add(new SelectOption(f.getLabel(), f.getValue()));
            }       
        return options;
    }
    
    public void setSurcharges(List<SelectOption> Surcharges){
        this.Surcharges = Surcharges;
    }
    
    public void retrieveSurchargeList(){
    account = [Select Id, Name, Total_Surcharge__c, (Select Id, Account__c, Surchange__c, Percentage__c, Amount__c From Surcharge__r order by Surchange__c) From Account where Id=:account.Id LIMIT 1];
    SurchargeList = account.Surcharge__r;
    //Generate a List of Surcharge strings which are already selected under an account eg. surcharge-1,surcharge-2,surcharge-3 etc
    existingSurchargeMap.clear();
	    for(Surcharge__c scharge : SurchargeList){
	    	existingSurchargeMap.put(scharge.Surchange__c , scharge.Surchange__c);	
	    }
    }
    
}