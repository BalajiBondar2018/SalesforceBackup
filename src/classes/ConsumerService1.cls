public with sharing class ConsumerService1 {
    //Consumer Search Interface response 
    public static void generateConsumerSearchResponse (string ConsumersearchXMLResponse){
    ConsumerResponseWrapper ConsumerResponseWrapperObj;
    List<Consumerwrapper>  ConsumerwrapperList = new List<Consumerwrapper>();   

    DOM.Document doc = new DOM.Document();      
    doc.load(ConsumersearchXMLResponse);    
    DOM.XMLNode root = doc.getRootElement();
    string xmlresponse = walkThrough(root);
    System.debug('@@@@@@@@@@xmlresponse '+xmlresponse );
    //ConsumerResponseWrapperObj = ConsumerResponseWrapper(root);
    /*
    for (Dom.XmlNode node : root.getChildElements()) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT && node.getAttributeCount() > 0 && node.getAttributeValue(node.getAttributeKeyAt(0), node.getAttributeKeyNsAt(0)) == 'CONSUMER_RECORD'){
            for (Dom.XmlNode consumer : node.getChildElements()) {
                System.debug('@@@@@@ consumer' + consumer);
            }
        }
    }    
    */
    }
    
    public static string walkThrough(DOM.XMLNode node) {
      String result = '\n';
      
      if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
        if (node.getAttributeCount() > 0) {
          //if(node.getAttributeValue(node.getAttributeKeyAt(0), node.getAttributeKeyNsAt(0)) == field){ 
          result += node.getAttributeValue(node.getAttributeKeyAt(0), node.getAttributeKeyNsAt(0));
          if (node.getText().trim() != '') {
          result += ',' + node.getText().trim();
          }
        //}  
      }      
        
        
        
        for (Dom.XMLNode child: node.getChildElements()) {
          result += walkThrough(child);
        }
        return result;
      }
      return '';  //should never reach here 
    }
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    
    public static ConsumerResponseWrapper ConsumerResponseWrapper(DOM.XMLNode node) {
        ConsumerResponseWrapper ConsumerResponseWrapperObj = new ConsumerResponseWrapper();
        List<consumerwrapper> consumerwrapperList = new List<consumerwrapper>();
        
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            if (node.getAttributeCount() > 0) { 
                if(node.getAttributeValue(node.getAttributeKeyAt(0), node.getAttributeKeyNsAt(0)) == 'CONSUMER_RECORD'){
                    for(Dom.XMLNode consumernode: node.getChildElements()){
                    consumerwrapperList.add(consumerwrapper(consumernode));    
                    //System.debug('@@@@@@@@@@consumernode' +consumernode);
                    }
                }
            }
            for (Dom.XMLNode child: node.getChildElements()) {
                ConsumerResponseWrapper(child);
            }
        }
    ConsumerResponseWrapperObj.ConsumerwrapperList = consumerwrapperList;
    //System.debug('@@@@@@@@@@ConsumerResponseWrapperObj' +ConsumerResponseWrapperObj);
    return ConsumerResponseWrapperObj;    
    }
   

    public static Consumerwrapper consumerwrapper(DOM.XMLNode consumernodeAll) {
    Consumerwrapper ConsumerwrapperObj = new Consumerwrapper();
    List<ConsumerIdwrapper> ConsumerIdwrapperList = new List<ConsumerIdwrapper>();    
        
        for (Dom.XMLNode consumernode: consumernodeAll.getChildElements()) {
            System.debug('@@@@@@@@@@consumernode' + consumernode);
            if (consumernode.getNodeType() == DOM.XMLNodeType.ELEMENT) {
                if (consumernode.getAttributeCount() > 0) { 
                   if(consumernode.getAttributeValue(consumernode.getAttributeKeyAt(0), consumernode.getAttributeKeyNsAt(0)) == 'CONSUMER_GIVEN_NAME' && consumernode.getText().trim() != null)
                       //System.debug('@@@@@@@@@@CONSUMER_GIVEN_NAME ' + consumernode.getText().trim());
                       ConsumerwrapperObj.CONSUMER_GIVEN_NAME = consumernode.getText().trim();
                   if(consumernode.getAttributeValue(consumernode.getAttributeKeyAt(0), consumernode.getAttributeKeyNsAt(0)) == 'CONSUMER_SURNAME' && consumernode.getText().trim() != null)
                       //System.debug('@@@@@@@@@@CONSUMER_SURNAME ' + consumernode.getText().trim());
                       ConsumerwrapperObj.CONSUMER_SURNAME = consumernode.getText().trim();
                   if(consumernode.getAttributeValue(consumernode.getAttributeKeyAt(0), consumernode.getAttributeKeyNsAt(0)) == 'CONSUMER_ID_RECORD'){
                        String result = consumeridwrapper(consumernode);
                        //System.debug('@@@@@@@@@@result ' + result );
                        ConsumerIdwrapperList.addAll(processconsumerIdwrapperList(result));
                        //System.debug('@@@@@@@@@@ConsumerIdwrapperList ' + ConsumerIdwrapperList);
                    }
                }
            }
        }
    ConsumerwrapperObj.consumerIdwrapperList = ConsumerIdwrapperList;
    System.debug('@@@@@@@@@@ConsumerwrapperObj' +ConsumerwrapperObj);
    return ConsumerwrapperObj;    
    }
    
    
    public static string consumerIdwrapper(DOM.XMLNode consumeridnode) {
    string result = '';
    //ConsumerIdwrapper ConsumerIdwrapperObj = new ConsumerIdwrapper();
    if (consumeridnode.getNodeType() == DOM.XMLNodeType.ELEMENT && consumeridnode.getAttributeCount() > 0) {
       if(consumeridnode.getAttributeValue(consumeridnode.getAttributeKeyAt(0), consumeridnode.getAttributeKeyNsAt(0)) == 'CONSUMER_ID_TYPE' && consumeridnode.getText().trim()!= null)
           result += consumeridnode.getText().trim() + ',';
       if(consumeridnode.getAttributeValue(consumeridnode.getAttributeKeyAt(0), consumeridnode.getAttributeKeyNsAt(0)) == 'CONSUMER_ID_NUM')
           result += consumeridnode.getText().trim() + '#';
    }
    
    for (Dom.XMLNode consumeridnode2 : consumeridnode.getChildElements()) {
        result += consumerIdwrapper(consumeridnode2);
    }    
    
    return result; 
    }
    
    public static List<ConsumerIdwrapper> processconsumerIdwrapperList(string result){
    List<ConsumerIdwrapper> ConsumerIdwrapperList = new List<ConsumerIdwrapper>();
    
    List<string> consumerIdstringList = result.split('#');
    //System.debug('@@@@@@@@@@consumerIdstringList '+consumerIdstringList);
    
        for(string consumerIdstringObj : consumerIdstringList){
            List<string> consumerIdKeyValue = consumerIdstringObj.split(',');
            ConsumerIdwrapper ConsumerIdwrapperObj = new ConsumerIdwrapper();
            ConsumerIdwrapperObj.CONSUMER_ID_TYPE = consumerIdKeyValue[0];
            ConsumerIdwrapperObj.CONSUMER_ID_NUM = consumerIdKeyValue[1];
            ConsumerIdwrapperList.add(ConsumerIdwrapperObj); 
        }
    
    return ConsumerIdwrapperList ;
    }
    
   
//---------------------------------------------Wrapper Class definations----------------------------------------------------------  
    public class ConsumerResponseWrapper{
    public string responsecode {get;set;}
    public string responsemsg {get;set;}
    public List<Consumerwrapper> ConsumerwrapperList {get;set;}
    }
    
   
    public class Consumerwrapper{
    public string CONSUMER_GIVEN_NAME{get;set;}
    public string CONSUMER_SURNAME{get;set;}
    public List<ConsumerIdwrapper> consumerIdwrapperList {get;set;}
    }
    
    public class ConsumerIdwrapper{
    public string CONSUMER_ID_TYPE {get;set;}
    public string CONSUMER_ID_NUM{get;set;}
    }
}


 /*
    
    */