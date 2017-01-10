global with sharing class GoogleChartsController {
    @RemoteAction   
    global static List<Opportunity> loadOpps() {
        return [select Id, Name, ExpectedRevenue, Amount from Opportunity order by CreatedDate DESC limit 5];
    }   
}