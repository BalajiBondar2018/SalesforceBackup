public with sharing class ClosureReportExtension {
public List<Contact> contactList = new List<Contact>();
public List<OfficeDepot__Closure_Report__c> letterClosureReportList = new List<OfficeDepot__Closure_Report__c>();

public List<OfficeDepot__Closure_Report__c> getletterClosureReportList(){
        return letterClosureReportList;
}

public void setletterClosureReportList(List<OfficeDepot__Closure_Report__c> letterClosureReportList){
        this.letterClosureReportList = letterClosureReportList;
}

public List<OfficeDepot__Closure_Report__c> dataChangeClosureReportList {get;set;}
public List<OfficeDepot__Closure_Report__c> regulatoryClosureReportList {get;set;}

    public ClosureReportExtension(ApexPages.StandardController controller) {
        //letterClosureReportList = new List<OfficeDepot__Closure_Report__c>();
        dataChangeClosureReportList = new List<OfficeDepot__Closure_Report__c>();
        regulatoryClosureReportList = new List<OfficeDepot__Closure_Report__c>();
        
        for(OfficeDepot__Closure_Report__c stateClosureReportObj :[SELECT OfficeDepot__Case__c,OfficeDepot__Comment__c,OfficeDepot__Completed_On__c,OfficeDepot__Description__c,OfficeDepot__Due_Date__c,OfficeDepot__Section__c FROM OfficeDepot__Closure_Report__c]){
            if(stateClosureReportObj.OfficeDepot__Section__c == 'Letter Information') letterClosureReportList.add(stateClosureReportObj );
            if(stateClosureReportObj.OfficeDepot__Section__c == 'Data Change Information') dataChangeClosureReportList.add(stateClosureReportObj );
            if(stateClosureReportObj.OfficeDepot__Section__c == 'Regulatory Information') regulatoryClosureReportList.add(stateClosureReportObj );
        }
     
    }
    
    public Pagereference SaveClick(){
                update letterClosureReportList;
                update dataChangeClosureReportList;
                update regulatoryClosureReportList;
                return null;
    }
    
    public Pagereference CancelClick(){
        return null;
    }
}