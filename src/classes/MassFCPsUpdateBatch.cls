global class MassFCPsUpdateBatch implements Database.Batchable<sObject>{
    global final String selectedParameter;//capture the selected parameter (offerprice(%)/margin(%))
    global final String query;//dynamic query string to fetch the FCP for processing
    global final Set<Id> productIdSet;//set of unique products to be processed for offerprice(%)/margin(%)
    global final Map<Id,String> ProductIdOperatorMap;//Map of unique product Ids and relative operatorts(+/-)
    global final Map<Id,Decimal> ProductIdVariationMap;//Map of unique product Ids and relative variation
       
    global MassFCPsUpdateBatch (String selectedParameter, Set<Id> productIdSet, Map<Id,String> ProductIdOperatorMap , Map<Id,Decimal> ProductIdVariationMap){
    this.selectedParameter = selectedParameter;
    this.productIdSet = productIdSet;
    this.ProductIdOperatorMap = ProductIdOperatorMap;
    this.ProductIdVariationMap = ProductIdVariationMap;
    //dynamic query to fetch the FCPs with filter criteria : Matching Product codes and status 'Activated'
    query = 'SELECT Id, cost_price__c, min_price__c, max_price__c, sales_price__c, Margin2__c,  mass_price_change__c, mass_price_change_Date__c, product__c, Status__c FROM  Flexible_Contract_Price__c where product__c IN:productIdSet and Status__c=\'Activated\'';
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
    //System.debug('--------------------Inside Execute Method.');
    //System.debug('--------------------scope.size() '+scope.size());  
    //System.debug('--------------------selectedParameter  '+selectedParameter);  
    //System.debug('--------------------productIdSet '+productIdSet);  
    //System.debug('--------------------ProductIdOperatorMap '+ProductIdOperatorMap);  
    //System.debug('--------------------ProductIdVariationMap '+ProductIdVariationMap);   
    
    List<Flexible_Contract_Price__c> updateFCPObjList = new List<Flexible_Contract_Price__c>();//List of FCPs to update with the offerprice/margin   
    
        for(sobject s : scope){
        //typecast sobject to FCP
        Flexible_Contract_Price__c FCPObj = (Flexible_Contract_Price__c)s;
        Decimal percentagechangeDecimal;//capture the variation in the decimal format    
       
            //If user selects the parameter to update as offerprice
            if(selectedParameter == 'offerprice'){
                //System.debug('--------------------offerprice');
                //check for the selected operator parameter for the selected Product
                if(ProductIdOperatorMap.containsKey(FCPObj.product__c) && ProductIdOperatorMap.get(FCPObj.product__c)=='Increase')
                    percentagechangeDecimal = ProductIdVariationMap.get(FCPObj.product__c);
                else if (ProductIdOperatorMap.containsKey(FCPObj.product__c) && ProductIdOperatorMap.get(FCPObj.product__c)=='Decrease')         
                    percentagechangeDecimal = (-1)*ProductIdVariationMap.get(FCPObj.product__c);
                
                //System.debug('--------------------percentagechangeDecimal'+percentagechangeDecimal);
                //System.debug('--------------------Before update FCPObj.sales_price__c '+FCPObj.sales_price__c);
                
                //Update the offer price based on the user input variation
                FCPObj.sales_price__c = FCPObj.sales_price__c + (FCPObj.sales_price__c * percentagechangeDecimal )/100;
                //System.debug('--------------------After change FCPObj.sales_price__c'+FCPObj.sales_price__c);
                
                //if FCP offer price is greater than Max Price set to Max Price
                //if FCP offer price is less than Min Price set to Min Price
                if(FCPObj.sales_price__c > FCPObj.max_price__c) FCPObj.sales_price__c = FCPObj.max_price__c;
                else if(FCPObj.sales_price__c < FCPObj.min_price__c) FCPObj.sales_price__c = FCPObj.min_price__c;
                //System.debug('--------------------After Min/Max check FCPObj.sales_price__c'+FCPObj.sales_price__c);
                
                //set the FCP Margin based on the final offer price
                FCPObj.Margin2__c = ((FCPObj.sales_price__c-FCPObj.cost_price__c)/FCPObj.sales_price__c)*100;
                //System.debug('--------------------Updated Margin FCPObj.Margin2__c '+FCPObj.Margin2__c);
                FCPObj.mass_price_change__c = true;
                FCPObj.mass_price_change_Date__c = System.Today();
                updateFCPObjList.add(FCPObj);     
        
            }
            else if(selectedParameter == 'margin'){
                //System.debug('--------------------Margin Block');
                if(ProductIdOperatorMap.containsKey(FCPObj.product__c) && ProductIdOperatorMap.get(FCPObj.product__c)=='Increase')
                    percentagechangeDecimal = ProductIdVariationMap.get(FCPObj.product__c);
                else if (ProductIdOperatorMap.containsKey(FCPObj.product__c) && ProductIdOperatorMap.get(FCPObj.product__c)=='Decrease')         
                    percentagechangeDecimal =(-1)*ProductIdVariationMap.get(FCPObj.product__c);
                
                //System.debug('--------------------percentagechangeDecimal '+percentagechangeDecimal);
                
                FCPObj.margin2__c = FCPObj.margin2__c + percentagechangeDecimal;            
                //System.debug('--------------------FCPObj.margin2__c '+FCPObj.margin2__c);
                
                FCPObj.sales_price__c = (FCPObj.Cost_Price__c *(100/(100-FCPObj.margin2__c))).setScale(2);
                
                //System.debug('--------------------FCPObj.sales_price__c '+FCPObj.sales_price__c);
                
                
                if(FCPObj.sales_price__c > FCPObj.max_price__c) FCPObj.sales_price__c = FCPObj.max_price__c;
                else if(FCPObj.sales_price__c < FCPObj.min_price__c) FCPObj.sales_price__c = FCPObj.min_price__c;
                //System.debug('--------------------FCPObj.sales_price__c '+FCPObj.sales_price__c);
                
                FCPObj.mass_price_change__c = true;
                FCPObj.mass_price_change_Date__c = System.Today();
                
                //System.debug('--------------------updateFCPObjList '+updateFCPObjList);
                updateFCPObjList.add(FCPObj);     
            }
        }      
    //System.debug('--------------------updateFCPObjList.size() '+updateFCPObjList.size());
    //System.debug('--------------------updateFCPObjList '+updateFCPObjList);
    update updateFCPObjList;
    }

    global void finish(Database.BatchableContext BC){
        AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =:BC.getJobId()];
        // Send an email to the Apex job's submitter notifying of job completion.  
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Job Id:'+ a.Id +'/FCP Mass Sales Price update ' + a.Status);
        mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}