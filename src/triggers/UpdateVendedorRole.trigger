trigger UpdateVendedorRole on OpportunityTeamMember (after insert, after update) {
Map <Id,Opportunity> opportunityMap = new Map <Id,Opportunity>();
List<Opportunity> opportunityObjList = new List<Opportunity>();
    for(OpportunityTeamMember opportunityTeamMemberObj : [select Id, TeamMemberRole, UserId, Opportunity.Id,Opportunity.vendedor__c from OpportunityTeamMember where Id IN:Trigger.New]){
        if(opportunityTeamMemberObj.TeamMemberRole == 'Sales Rep'){
            opportunity  opportunityObj = opportunityTeamMemberObj.Opportunity;
            opportunityObj.vendedor__c = opportunityTeamMemberObj.UserId;
            opportunityObjList.add(opportunityObj);
        }   
    }
    update opportunityObjList;
}