//Bug Fix 02112017 Balaji Update
//Controller used for the AutoComplete Enhancement
public with sharing class AComplete_Controller{
   //Attributes
    private List<String> resultsname = new List<String>();
    private Boolean hasparams = false;
    private Boolean hasnoresults = false;
        
    //Getters and Setters
    public Boolean getHasparams(){
        return hasparams;
    }
    
    public void clearValues(){
        hasparams = false;
    }
    
    public Boolean getHasnoresults(){
        return hasnoresults;    
    }

   // public void avoidRefresh(){
   // }
    
     public PageReference searchSuggestions() {
        //Initalize variables, hasparams just indicates that a search has started
        resultsname.clear();   
        hasparams = true;
        hasnoresults = false;

        //Obtain current parameters
        String sobjectname = System.currentPageReference().getParameters().get('objectname');
        String stext = '%'+String.escapeSingleQuotes(System.currentPageReference().getParameters().get('aname').trim())+'%';
        
        //Limit Suggestions to 10 Results
        Integer iLimit = 10;
        
     //Validate if there's an input and get results
     
     if(stext.length() > 2){
        try{
              String sql = 'select name from ' + sobjectname + ' where name like \''+stext+'\' limit '+ iLimit;
                    
                    for(sobject x : Database.query(sql)){
                        
                        String s  = String.escapeSingleQuotes(((String)(x.get('name'))));
                        resultsname.add(s); 
                    }
        }catch(Exception e){
         resultsname.add('Unexpected Error, please contact support');
        }
     }
       return null;
  }
  
     public List<String> getResultsname(){
          //Make sure to clear past values
          clearValues();
          if(resultsname.isEmpty()){
            hasnoresults = true;
            resultsname.add('No Results');
          }
          return resultsname;
      }
}