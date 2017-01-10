public class LetterTableExtension {
public List<String> columnNameList {get;set;}
public List<String> selectedValueList{get;set;}


    public LetterTableExtension(ApexPages.StandardController controller) {
    leftselected = new List<String>();
        rightselected = new List<String>();
        leftvalues.addAll(originalValues);
    }
    
    Set<String> originalvalues = new Set<String>{'A','B','C','D','E','F','G'};
    Public List<string> leftselected{get;set;}
    Public List<string> rightselected{get;set;}
    public Set<string> leftvalues = new Set<string>();
    public Set<string> rightvalues = new Set<string>();
     
    public PageReference selectclick(){
        rightselected.clear();
        for(String s : leftselected){
            leftvalues.remove(s);
            rightvalues.add(s);
        }
        return null;
    }
     
    public PageReference unselectclick(){
        leftselected.clear();
        for(String s : rightselected){
            rightvalues.remove(s);
            leftvalues.add(s);
        }
        return null;
    }
 
    public List<SelectOption> getunSelectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(leftvalues);
        tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }
 
    public List<SelectOption> getSelectedValues(){
        selectedValueList = new List<String>();
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        
        
       
        tempList.addAll(rightvalues);
        tempList.sort();
        System.debug('@@@@@@@@@@@rightvalues '+rightvalues);
        
        for(String s : tempList){
            options1.add(new SelectOption(s,s));
            selectedValueList.add(s);
        }    
        return options1;
    }
}