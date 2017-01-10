//Description
trigger AssignCloseOppTeamMember on OpportunityTeamMember (after insert) {
    //variable deceleration
    List<Opportunity> OpportunityList = new List<Opportunity>();//List of opportunity records
    Map<Id, Id> OppIdOppMemberIdMap = new Map<Id, Id>();//Map of Opportunity Id & OpportunityTeamMember Id

    try{
	    for(OpportunityTeamMember OpportunityTeamMemberObj: Trigger.New){
	        if(OpportunityTeamMemberObj.TeamMemberRole =='Closer')//Check the role of Opportunity Team Member role
	            OppIdOppMemberIdMap.put(OpportunityTeamMemberObj.OpportunityId , OpportunityTeamMemberObj.Id);
	    }
	    
	    if(OppIdOppMemberIdMap.size() != 0){
	        for(Opportunity opportunityObj : [Select Id, Closer_Opportunity_Team_Member__c from Opportunity where Id IN: OppIdOppMemberIdMap.keyset()]){
	            if(OppIdOppMemberIdMap.Containskey(opportunityObj.Id)){
	                opportunityObj.Closer_Opportunity_Team_Member__c = OppIdOppMemberIdMap.get(opportunityObj.Id);
	                OpportunityList.add(opportunityObj);
	            }
	        }
	    }
	    if(OpportunityList.size() != 0) update OpportunityList;
    }catch(Exception ex){
    	System.debug(ex);
    }
}