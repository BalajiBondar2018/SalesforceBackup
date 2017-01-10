public with sharing class ConsumerService {
    //Consumer Search Interface response 
    public static ConsumerResponseWrapper generateConsumerSearchResponse (string ConsumersearchXMLResponse){
        ConsumerResponseWrapper ConsumerResponseWrapperObj;
        List<Consumerwrapper>  ConsumerwrapperList = new List<Consumerwrapper>();
        boolean isSafeToGetNextXmlElement = true;
        XmlStreamReader reader = new XmlStreamReader(ConsumersearchXMLResponse);
        String RETURN_CODE = '';
        String RETURN_MSG = '';
        
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if ('RETURN_CODE' == reader.getAttributeValue(null, 'name')) {
                    RETURN_CODE = parseString(reader);
                }
            }
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if ('RETURN_MSG' == reader.getAttributeValue(null, 'name')) {
                    RETURN_MSG = parseString(reader);
                }
            }    
                //System.debug('^^^^' + reader.getLocalName());
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if ('CONSUMER_RECORD' == reader.getAttributeValue(null, 'name')) {
                    //System.debug('^^^^' + reader.getAttributeValue(null, 'name'));
                    Consumerwrapper  ConsumerwrapperObj = parseConsumerwrapper(reader);
                    //System.debug('@@@@@@ConsumerwrapperObj '+ConsumerwrapperObj);
                    ConsumerwrapperList.add(ConsumerwrapperObj);
                }
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        
        ConsumerResponseWrapperObj = new ConsumerResponseWrapper(RETURN_CODE,RETURN_MSG,ConsumerwrapperList);
        return ConsumerResponseWrapperObj; 
    }
    
//-------------------------------------------------support methods----------------------------------------------------------    
    public static Consumerwrapper parseConsumerwrapper(XmlStreamReader reader) {
       Consumerwrapper ConsumerwrapperObj = new Consumerwrapper();
       List<ConsumerIdwrapper>  ConsumerIdwrapperList = new List<ConsumerIdwrapper>();
        boolean isSafeToGetNextXmlElement = true;

        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                isSafeToGetNextXmlElement = false;  
                   break;
            }
            
            if(reader.getEventType() == XmlTag.START_ELEMENT){
                if ('CONSUMER_GIVEN_NAME' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_GIVEN_NAME= parseString(reader);
                        //System.debug('@@@@@@@@@@CONSUMER_GIVEN_NAME'+CONSUMER_GIVEN_NAME);
                        ConsumerwrapperObj.CONSUMER_GIVEN_NAME  =  CONSUMER_GIVEN_NAME;
                }
           }
                
            if(reader.getEventType() == XmlTag.START_ELEMENT){
                if ('CONSUMER_SURNAME' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_SURNAME= parseString(reader);
                        ConsumerwrapperObj.CONSUMER_SURNAME= CONSUMER_SURNAME;
                }
            }
            
            
            if(reader.getEventType() == XmlTag.START_ELEMENT){
               if ('CONSUMER_ID_RECORD' == reader.getAttributeValue(null, 'name')) {
                    System.debug('@@@@@CONSUMER_ID_RECORD found.');
                    ConsumerIdwrapper  ConsumerIdwrapperObj = parseConsumerIdwrapper(reader);
                    ConsumerIdwrapperList.add(ConsumerIdwrapperObj);
               }
           }
           
           // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }        
        ConsumerwrapperObj.ConsumerIdwrapperList=ConsumerIdwrapperList;
        return ConsumerwrapperObj;
    }
    
    
    public static ConsumerIdwrapper parseConsumerIdwrapper(XmlStreamReader reader) {
    //System.debug('@@@@@@@@@reader '+reader);
    ConsumerIdwrapper ConsumerIdwrapperObj = new ConsumerIdwrapper ();
    
    boolean isSafeToGetNextXmlElement = true;

        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                isSafeToGetNextXmlElement = false;  
                   break;
            }
            
            if(reader.getEventType() == XmlTag.START_ELEMENT){
                if ('CONSUMER_ID_TYPE' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_ID_TYPE= parseString(reader);
                        //System.debug('@@@@@@@@@@CONSUMER_GIVEN_NAME'+CONSUMER_GIVEN_NAME);
                        ConsumerIdwrapperObj.CONSUMER_ID_TYPE  =  CONSUMER_ID_TYPE;
                }
           }
                
            if(reader.getEventType() == XmlTag.START_ELEMENT){
                if ('CONSUMER_ID_NUM' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_ID_NUM= parseString(reader);
                        ConsumerIdwrapperObj.CONSUMER_ID_NUM = CONSUMER_ID_NUM;
                }
            }
            
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }        
    
               
    System.debug('@@@@@@@@@@@ConsumerIdwrapperObj '+ConsumerIdwrapperObj);
    return ConsumerIdwrapperObj ;
    }

    
    
    
    public static String parseString(XmlStreamReader reader) {
        String ret = '';

        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            //System.debug('****EVENTTYPE' + reader.getEventType());
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS) {
                //System.debug('****Characters |' + reader.getText() + '|');
                ret = ret + reader.getText();
            } else if (reader.getEventType() == XmlTag.CDATA) {
               // System.debug('****CDATA');
                ret = reader.getText();
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        return ret.trim();
    }
    
//---------------------------------------------Wrapper Class definations----------------------------------------------------------  
    public class ConsumerResponseWrapper{
    public string responsecode {get;set;}
    public string responsemsg {get;set;}
    public List<Consumerwrapper> ConsumerwrapperList {get;set;}
        public ConsumerResponseWrapper(string responsecode , string responsemsg , List<Consumerwrapper> ConsumerwrapperList){
            this.responsecode = responsecode;
            this.responsemsg = responsemsg;
            this.ConsumerwrapperList = ConsumerwrapperList;
        }
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