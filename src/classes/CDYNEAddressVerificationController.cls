public class CDYNEAddressVerificationController {
public Account acct = new Account();
public string JSONString ;
public void CDYNEAddressVerificationController(){
//Instantiate addressInformation Object 
 addressInformation ai = new addressInformation(acct.ShippingCity, '', acct.ShippingStreet, acct.ShippingState,'', acct.ShippingPostalCode); 
 //Serialize the object to JSON format 
 JSONString = JSON.serializePretty(ai); 
 System.debug('Serialized Address: ' + JSONString);
 HttpRequest req = new HttpRequest(); 
  
 //Set HTTPRequest Method 
 req.setMethod('POST'); 
  
//Set HTTPRequest header proporties 
 req.setHeader('content-type', 'application/json'); 
 req.setHeader('Accept', 'application/json'); 
  
 //Set HTTPRequest Endpoint 
 req.setEndpoint('YOUR ENDPOINT URL HERE'); 
  
//Set HTTP Request Body 
 req.setBody(JSONString); 
 
 
 System.HttpResponse res = new System.Http().send(req); 
  
 //Helpful debug messages 
 System.debug(res.toString()); 
 System.debug('STATUS:'+res.getStatus()); 
 System.debug('STATUS_CODE:'+res.getStatusCode()); 
 System.debug('Content: ' + res.getBody()); 
  
//Save the HTTP Response in a deserialized map 
 Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody()); 
  
//If the reponse if valid, map the fields and display the output 
 if(String.valueOf(response.get('ReturnCode')) != '10' && String.valueOf(response.get('ReturnCode')) != '1'){ 
 //TODO: Map the MSAG Fields from the response 
 System.debug('Address is valid'); 
 /*
 acct.SRV_MSAG_City__c = String.valueOf(response.get('CityName')); 
 acct.SRV_MSAG_Number__c = String.valueOf(response.get('Primary')); 
 acct.SRV_MSAG_Post_Direction__c = String.valueOf(response.get('PostDirectional')); 
 acct.SRV_MSAG_Pre_Direction__c = String.valueOf(response.get('PreDirectional')); 
 acct.SRV_MSAG_State__c = String.valueOf(response.get('StateAbbreviation')); 
 acct.SRV_MSAG_Street_Name_2__c = String.valueOf(response.get('SecondaryAddressLine')); 
 acct.SRV_MSAG_Street_Name__c = String.valueOf(response.get('StreetName')); 
 acct.SRV_MSAG_Street_Number_Suffix__c = String.valueOf(response.get('SecondaryAbbreviation')); 
 acct.SRV_MSAG_Street_Suffix__c = String.valueOf(response.get('Suffix')); 
 acct.SRV_MSAG_Zip__c = String.valueOf(response.get('ZipCode')); 
 acct.Service_Address_Latitude__c = String.valueOf(response.get('AvgLatitude')); 
 acct.Service_Address_Longitude__c = String.valueOf(response.get('AvgLongitude')); 
 acct.Service_Address_Verified__c = 'Yes'; 
 */
 update acct; 
 }else{ 
 System.debug('Address is not valid'); 
 ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Could not verify address information'); 
 ApexPages.addMessage(errorMsg); 
 }

 
 
 
 
 
  


}

//Class used to serialize address information into JSON format 
 public class addressInformation { 
 String cityName; 
 String FirmOrRecipient; 
 String LicenseKey; 
 String PrimaryAddressLine; 
 String State; 
 String Urbanization; 
 String ZipCode; 
 Boolean ReturnGeoLocation; 
 Boolean ReturnCaseSensitive; 
  
 public addressInformation(String c, String f, String p, String s, String u, String z){ 
     cityName = c; 
     FirmOrRecipient = f; 
     LicenseKey = 'YOUR LICENSE KEY HERE'; 
     PrimaryAddressLine = p; 
     State = s; 
     Urbanization = u; 
     ZipCode = z; 
     ReturnGeoLocation = True; 
     ReturnCaseSensitive = True; 
     } 
 }

 

}