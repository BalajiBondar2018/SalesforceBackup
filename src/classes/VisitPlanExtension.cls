public class VisitPlanExtension {
public Account accountObj;
    
    public VisitPlanExtension(ApexPages.StandardController controller) {
    accountObj = (Account)controller.getRecord(); 
    }

}