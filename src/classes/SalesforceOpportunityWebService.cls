global class SalesforceOpportunityWebService {
    webService static String createOpportunity(String MID) {
        //variable decleration
        String responseStr = '';//string to capture the response message to SOA
        Opportunity MIDopportunityObj = new Opportunity ();//existing Opportunity object with mathcing MID
        Opportunity opportunityObj = new Opportunity ();//new Opportunity object
        Case caseObj = new Case(); //new Case object
        //Post_Sale_Task__c  postSaleTaskObj = new Post_Sale_Task__c ();//new Task object
        
        //fetch the existing Opportunity object with matching MID code
        MIDopportunityObj = [select Id from Opportunity LIMIT 1];
        if(MIDopportunityObj != Null){
            //setup the save point for rollback
            Savepoint sp = Database.setSavepoint();
            try{
                // The first parameter set to false tells the method NOT to clone the ID
                // The second one tells it to clone every field and relationship that is loaded in memory in the existing Opportunity object.
                opportunityObj = MIDopportunityObj.clone(false,true);
                System.debug('@@@@@@@@@opportunityObj '+opportunityObj);

                //insert new case object 
                caseObj  = createCase();           
                //caseObj.Opportunity__c = opportunityObj.Id;  
                insert caseObj;
                System.debug('@@@@@@@@@caseObj  '+caseObj);
                
                /*
                //insert new postSaleTaskObj object
                postSaleTaskObj = createPostSaleTask();
                postSaleTaskObj.case__c = caseObj.Id;
                insert postSaleTaskObj;
                System.debug('@@@@@@@@@postSaleTaskObj'+postSaleTaskObj);
                */
            responseStr ='Opportunity successfully created.';
            return responseStr ;           
            }catch( Exception ex){
            //roll everything back in case of error
            Database.rollback(sp);
            responseStr ='Exception :' + ex;
            System.debug('@@@@@@@@@responseStr '+responseStr);
            return responseStr ;
            }
        }    
        else{//else loop:no Opportunity with MID exists 
            responseStr ='No opportunity exists with MID.';
            System.debug('@@@@@@@@@responseStr '+responseStr);
            return responseStr ;
        }
    }
    
    //create a case object with static information
    public static  Case createCase(){
    Case caseObj = new Case();
    
    return caseObj ;
    }

    /*
    //create a task object with static information    
    public static Post_Sale_Task__c createPostSaleTask(){
    Post_Sale_Task__c  postSaleTaskObj = new Post_Sale_Task__c ();
    
    
    return postSaleTaskObj ;
    }
    */
}