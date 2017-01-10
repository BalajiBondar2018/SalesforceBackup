trigger PopulatePartner on Opportunity (after Insert) {
Set <Id> accountIdSet = new Set<Id>();
Map<Id , Partner> AccountIdPartnerMap = new Map<Id , partner>();
List<OpportunityPartner> partnerList = new List<OpportunityPartner>();

    for(Opportunity OpportunityObj :Trigger.New){
        accountIdSet.add(OpportunityObj.AccountId );
    }

    for(Partner partnerObj : [Select Id, Role, OpportunityId, AccountToId From Partner where Role='Vendor']){
        AccountIdPartnerMap.put(partnerObj.AccountToId , partnerObj); 
    }
    
    for(Opportunity OpportunityObj :Trigger.New){
        if(AccountIdPartnerMap.containskey(OpportunityObj.AccountId)){
            OpportunityPartner partnerObj = new OpportunityPartner ();
            //partnerObj.role =  AccountIdPartnerMap.get(OpportunityObj.AccountId).role;
            //partnerObj.OpportunityId = OpportunityObj.Id; 
            //partnerObj.AccountToId =  AccountIdPartnerMap.get(OpportunityObj.AccountId).AccountToId;

            
            partnerList.add(partnerObj ); 
        }
    }
    //insert partnerList;
}