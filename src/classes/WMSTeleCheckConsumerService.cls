global class WMSTeleCheckConsumerService{
   
    Webservice static WMSTeleCheckServiceResponseWrapper createACase(String requestXMLStr){
    //variable decleration
    WMSTeleCheckServiceResponseWrapper WMSTeleCheckServiceResponseWrapperObj; 
    Map<String,String> requestMap = new Map<String, String>();
    Case caseObj = new Case();

    try{    
        requestMap = WMSTeleCheckServiceHandler.parseXML(requestXMLStr);
        
        caseObj = WMSTeleCheckServiceHandler.createCaseObject(requestMap);
        insert caseObj;
       
        WMSTeleCheckServiceResponseWrapperObj = new WMSTeleCheckServiceResponseWrapper('Success', caseObj.Id,null);
        return WMSTeleCheckServiceResponseWrapperObj ;
        }catch(Exception ex){
	        WMSTeleCheckServiceResponseWrapperObj = new WMSTeleCheckServiceResponseWrapper('Fail', null, ex.getMessage());
	        return WMSTeleCheckServiceResponseWrapperObj ;
        }
    }
    
    
    //--------------------------Wrapper Class to handle request & response------------------------------
    global class WMSTeleCheckServiceResponseWrapper{
     Webservice String result {get;set;}
     Webservice String recordId {get;set;}
     Webservice String errorlog {get;set;}
        public WMSTeleCheckServiceResponseWrapper(String result, String recordId, String errorlog){
        this.result= result;
        this.recordId= recordId;
        this.errorlog = errorlog;
        }
    }
}