/**
author        : www.aslambari.com
date          : 26 May, 2011
description   : Main page which collects data for different sheets
*/
public class MultiSheetExcelGenerate{
    public DataModel dm {get;set;}
    public MultiSheetExcelGenerate(){
        dm = new DataModel();
        dm.data = new list<DataModel.Model>();
        /**
        Fetching Accout data
        */
        DataModel.Model model = new DataModel.Model();
        model.sheetname = 'Account';
        model.headers = new list<string>{'Id','Name','Phone','BillingCountry'};
        model.data = new list<map<string,string>>();
        for(Account act: [SELECT Id, Name, Phone, BillingCountry from Account Where BillingCountry != null and Phone != null]){
            map<string,string> rowdata = new map<string,string>();
            rowdata.put('Id',act.Id);
            rowdata.put('Name',act.Name);
            rowdata.put('Phone',act.Phone);
            rowdata.put('BillingCountry',act.BillingCountry);
            model.data.add(rowdata);
        }
        dm.data.add(model);
        
        model = new DataModel.Model();
        model.sheetname = 'Contact';
        model.headers = new list<string>{'Id','Name','Phone','Email'};
        model.data = new list<map<string,string>>();
        for(Contact cnt: [SELECT Id, Name, Phone, Email from Contact Where Email != null and Phone != null]){
            map<string,string> rowdata = new map<string,string>();
            rowdata.put('Id',cnt.Id);
            rowdata.put('Name',cnt.Name);
            rowdata.put('Phone',cnt.Phone);
            rowdata.put('Email',cnt.Email);
            model.data.add(rowdata);
        }
        dm.data.add(model);
    }

}