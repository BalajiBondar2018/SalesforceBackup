global class GSBDataPreLoaderWebService {
    //Method to generate the lead records from the PreLoader system
    webService static String gererateLeads(String channelId, String partnerId, String branchId , String agentId , List<Lead> merchantList) {
        //variable decleration
        String responsemessage='';
        List<Lead> newLeadList = new List<Lead>();    
        //input data Id validate
        //Id channelId = [select Id from Channel__c where Id=:channelId LIMIT 1].Id;
        //Id partnerId = [select Id from Partner__c where Id=:partnerId LIMIT 1].Id;
        //Id branchId = [select Id from Branch__c where Id=:branchId LIMIT 1].Id;
        //Id agentId = [select Id from User__c where Id=:agentId LIMIT 1].Id;

      try{
        if(channelId =='' || channelId == Null){ return 'channelId is not valid.';}
        else if(partnerId == '' || partnerId == Null){ return 'partnerId is not valid.';}
        else if(branchId =='' || branchId == Null){ return 'branchId  is not valid.';}
        else if(agentId =='' || agentId == Null){ return 'agentId is not valid.';}
        else if(merchantList.size() == 0){ return 'Merchant data is missing';}
        else{
            for(Lead merchantObj : merchantList){
                Lead leadObj = new Lead();
                leadObj = MerchantToLeadFieldMapping(merchantObj);
                //leadObj.ChannelId = channelId;
                //leadObj.partnerId = partnerId;
                //leadObj.branchId =  branchId ;
                //leadObj.agentId =  agentId ;
                newLeadList.add(leadObj); 
             }//End of for loop
        insert newLeadList;
        responsemessage = 'Merchant records are successfully created.';
        }//End of Else            
        return responsemessage;
        }//End of Try
        catch(Exception ex){
            responsemessage = 'Error while lead creation.contact to System Administrator.' + ex ;
            return responsemessage;
        }//End of catch
    }//End of gererateLeads
    
    //method to map Merchant-Lead field values
    public static Lead MerchantToLeadFieldMapping(Lead mertchantObj){
        Lead leadObj = new Lead();
        leadObj.LastName =  mertchantObj.LastName;
        leadObj.FirstName =  mertchantObj.FirstName ;
        leadObj.Phone =  mertchantObj.Phone;
    return leadObj;
    }
    
}