public class CreateIssueExtension {
public List<Case> issueList {get;set;}

    
    
    public CreateIssueExtension(ApexPages.StandardController controller) {
issueList = [select Id,casenumber,Description,Priority,Status, origin from Case LIMIT 5];
    }

}