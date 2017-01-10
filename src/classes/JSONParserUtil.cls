public class JSONParserUtil {
    @future(callout=true)
    public static void parseJSONResponse() {        
        Http httpProtocol = new Http();
        // Create HTTP request to send. 
    
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL. 
    
        String endpoint = 'http://www.cheenath.com/tutorial/sfdc/sample1/response.php';
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET. 
    
        request.setMethod('GET');
        // Send the HTTP request and get the response. 
    
        // The response is in JSON format. 
    
        HttpResponse response = httpProtocol.send(request);
        System.debug('@@@@@@@@@@@@@response.getBody() '+response.getBody());

        // Parse JSON response to get all the totalPrice field values. 
    
        JSONParser parser = JSON.createParser(response.getBody());
        Double grandTotal = 0.0;
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'totalPrice')) {
                // Get the value. 
    
                parser.nextToken();
                // Compute the grand total price for all invoices. 
    
                grandTotal += parser.getDoubleValue();
            }
        }
        system.debug('@@@@@@@@@@@@@@@@@Grand total=' + grandTotal);
    }   
}