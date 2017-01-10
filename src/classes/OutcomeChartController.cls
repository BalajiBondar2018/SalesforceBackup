public class OutcomeChartController{
//variable declearion   
public Map<String,Integer> totalWCIMap = new Map<String,Integer>();
public Map<String,Integer> openWCIMap = new Map<String,Integer>();
public List<WCICompletionRateWrapper> WCICompletionRateWrapperList = new List<WCICompletionRateWrapper>();
	//get wrapper object to be sent to UI JSON method
    public List<WCICompletionRateWrapper> getWCICompletionRateWrapperList(){
        //map of Open WCI
        for(AggregateResult ar :[Select o.Owner.Name,count(Id) From OfficeDepot__Work_Case_Item__c o 
                                        where  o.OfficeDepot__Owner_Type__c='Queue' and o.OfficeDepot__Status__c='Open' group by o.Owner.Name]){
            openWCIMap.put(String.valueof(ar.get('Name')), Integer.valueof(ar.get('expr0')));
        }
        //get wrapper object
        for(AggregateResult ar :[Select o.Owner.Name,count(Id) From OfficeDepot__Work_Case_Item__c o 
                                        where  o.OfficeDepot__Owner_Type__c='Queue' group by o.Owner.Name]){
            if(openWCIMap.get(String.valueof(ar.get('Name'))) != Null)
                WCICompletionRateWrapperList.add(new WCICompletionRateWrapper(String.valueof(ar.get('Name')),Integer.valueof(ar.get('expr0')),openWCIMap.get(String.valueof(ar.get('Name')))));
            else
                WCICompletionRateWrapperList.add(new WCICompletionRateWrapper(String.valueof(ar.get('Name')),Integer.valueof(ar.get('expr0')),0));//set Open WCI count to 0                
        }
        System.debug('@@@@@@@@@@@WCICompletionRateWrapperList '+WCICompletionRateWrapperList);
    return WCICompletionRateWrapperList;
    }

	//wrapper class
	public class WCICompletionRateWrapper{
	    public String queueName {get;set;}
	    public Integer totalWCICount {get;set;}
	    public Integer openWCICount {get;set;}
	    public WCICompletionRateWrapper(String queueName ,Integer totalWCICount, Integer openWCICount){
	        this.queueName = queueName;
	        this.totalWCICount = totalWCICount;
	        this.openWCICount = openWCICount;
	    }
	}
}