public class QuickBookPageExtension {
  public String Headers {get; set;}
  public String Response {get; set;}

    public QuickBookPageExtension(ApexPages.StandardController controller) {
        System.HttpRequest request = new System.HttpRequest();
        //request.setEndpoint('https://qbo.intuit.com/qbo28/resource/account/v2/652983520');
        request.setEndpoint('https://appcenter.intuit.com/api/v1/Account/AppMenu');
         
        request.setMethod('GET');

        //request.setHeader('realm','652983520');
        request.setHeader('oauth_version','1.0');
        request.setHeader('oauth_consumer_key','qyprdAGlGdBfUhqimkgQ9e3vgV6iOi');
        request.setHeader('oauth_token','qyprd3ls5RdpDmeX1iMxhafLvIXNuneOGfctk7IZXsiq8ooz');
        request.setHeader('oauth_signature_method','HMAC-SHA1');
        request.setHeader('oauth_signature','tjifxK4PHC2QlTdwTywrQTJCRnU');
        request.setHeader('oauth_nonce','DvebnZqlnkT');
        request.setHeader('oauth_timestamp','1363349804');
        //request.setHeader('Content-Length', '512');
        //request.setTimeout(600);
        
        request.setHeader('Content-type','application/xml');
        //request.setHeader('Content-type','application/x-www-form-urlencoded');
        //request.setBody(data);
        
        System.debug('@@@@@@@@@@@@request'+request);
        System.HttpResponse response = new System.Http().send(request);
        this.Response = response.getBody();
    }
  


}