public class RestAPIMetadataExplorerController {
    private final String BASE_REST_URL_PREFIX = '/services/data/v20.0/sobjects/Account/describe';
    
    public String url {get; set;}
    public String requestBody {get; set;}
    public String requestMethod {get; set;}
    public String rawResponseHeaders {get; private set;}
    public String rawResponse {get; private set;}
    public String response {get; private set;}
    final String sessionId = UserInfo.getSessionId();
    private RestClient client;
    private RestResponseInstrumenter insturmenter;

    public PageReference ShowMetadataClick() {
        //url ='/services/data';
        // clear any old values, in case we don't populate them on this request
        rawResponseHeaders = null;
        rawResponse = null;
        response = null;
        ApexPages.currentPage().getParameters().put('autoExec',null);
        final String staticBaseUrl;
        staticBaseUrl = 'https://ap1.salesforce.com';
        
        
        final String sessionId = UserInfo.getSessionId();
        ConnectorConfig config = new ConnectorConfig(staticBaseUrl, sessionId);
        client = new RestClient(config);
        requestMethod ='GET';
        requestBody = null;
        // send the resonse 
        url = BASE_REST_URL_PREFIX;
        
        HttpResponse httpResponse = client.send(requestMethod,url,requestBody );
        // process the body
        rawResponse = httpResponse.getBody();        
        //JSONParser parser = JSON.createParser(rawResponse);
        
        return null;
    }
}