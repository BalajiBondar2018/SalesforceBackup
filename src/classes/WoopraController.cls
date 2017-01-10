public class WoopraController {
  public String Headers {get; set;}
  public String Response {get; set;}

  public void doRequest() {
  String data = '{'
    + '\n' + '"website":"balajibondar.com",'
    + '\n' + '"segment":['
    + '\n' + '  {'
    + '\n' + '    "did":{'
    + '\n' + '      "operator":"AND",'
    + '\n' + '      "filters":['
    + '\n' + '        {'
    + '\n' + '          "scope":"actions",'
    + '\n' + '          "key":"name",'
    + '\n' + '          "match":"match",'
    + '\n' + '          "value":"quote"'
    + '\n' + '        }'
    + '\n' + '      ]'
    + '\n' + '    },'
    + '\n' + '    "are":{'
    + '\n' + '      "operator":"AND",'
    + '\n' + '      "filters":[]'
    + '\n' + '    }'
    + '\n' + '  }'
    + '\n' + '],'
    + '\n' + '"offset":0,'
    + '\n' + '"report_id":-1' +
  '}';
  System.debug('@@@@@@@@@@@@data '+data);
  System.HttpRequest request = new System.HttpRequest();
  request.setEndpoint('http://www.woopra.com/rest/search');
  request.setMethod('POST');

  request.setHeader('X-Api-Version','2.0');
  request.setHeader('X-Access-Id','WLMX7M88RXWXXKN3ZZMFNN1W7QKDVACU');
  request.setHeader('X-Access-Secret','QcLlZayZGtdboV56CAbjzVcJ09p0jDxYrOh0PVqhwxjjA4jy8vFNgFzx0d51nxXm');
  request.setBody(data);
  
  System.debug('@@@@@@@@@@@@request'+request);
  System.HttpResponse response = new System.Http().send(request);
  //System.assert(false, response); //remove this once you fix the 403
  //System.debug('@@@@@response.getBody();'+response.getBody());
  this.Response = response.getBody();
  }

}