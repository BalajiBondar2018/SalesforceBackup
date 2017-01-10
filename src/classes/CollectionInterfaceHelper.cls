/*
Map<string , string> collectionsearchparameterMap = new Map<string , string>();

collectionsearchparameterMap.put('USER_ID','balajibondar');
collectionsearchparameterMap.put('SEARCH_CONSUMER_SURNAME','123456789');
collectionsearchparameterMap.put('SEARCH_CONSUMER_NAME','987654321');

collectionsearchparameterMap.put('CONSUMER_STREET','Pacific Street');
collectionsearchparameterMap.put('CONSUMER_CITY','Omaha');
collectionsearchparameterMap.put('CONSUMER_STATE','NE');
collectionsearchparameterMap.put('CONSUMER_ZIP','68124');

collectionsearchparameterMap.put('PassportNo','Z78667');
collectionsearchparameterMap.put('SSN','345678');
collectionsearchparameterMap.put('DrivingLicense','ABC12345');

string collectionsearchXMLRequest = CollectionInterfaceHelper.generateCollectionSearchRequest(collectionsearchparameterMap);
System.debug('@@@@@@'+collectionsearchXMLRequest);
*/
public with sharing class CollectionInterfaceHelper {
    //Collection Search Interface request 
    public static String generateCollectionSearchRequest(Map<string , string> collectionsearchparameterMap){
    string collectionsearchXMLRequest='';//To store the XML request based on collection search criteria
    Xmlstreamwriter xmlW = new Xmlstreamwriter(); //XMLStreamWriter object
        xmlW.writeStartDocument('utf-8','1.0');
            xmlW.writeStartElement('xsd','schema', ''); 
            xmlW.writeAttribute(null,null,'xmlns:xsd','http://www.w3.org/2001/XMLSchema');
                xmlW.writeStartElement('xsd','element', '');
                xmlW.writeAttribute(null,null,'name','collections_search');
                    xmlW.writeStartElement('xsd','complexType', '');
                        xmlW.writeStartElement('xsd','all', '');        
                            //check if USER_ID key exists in collectionsearchparameterMap and value is not null
                            if(collectionsearchparameterMap.containskey('USER_ID') && collectionsearchparameterMap.get('USER_ID') != ''){
                                xmlW.writeStartElement('xsd','element', '');
                                xmlW.writeAttribute(null,null,'name','USER_ID');
                                xmlW.writeAttribute(null,null,'minOccurs','0');
                                xmlW.writeAttribute(null,null,'type','xsd:string');
                                    xmlW.writeCharacters(collectionsearchparameterMap.get('USER_ID'));
                                xmlW.writeEndElement(); //close USER_ID
                            }
                            //check if SEARCH_CONSUMER_SURNAME key exists in collectionsearchparameterMap and value is not null
                            if(collectionsearchparameterMap.containskey('SEARCH_CONSUMER_SURNAME') && collectionsearchparameterMap.get('SEARCH_CONSUMER_SURNAME') != ''){
                                xmlW.writeStartElement('xsd','element', '');
                                xmlW.writeAttribute(null,null,'name','SEARCH_CONSUMER_SURNAME');
                                xmlW.writeAttribute(null,null,'minOccurs','0');
                                xmlW.writeAttribute(null,null,'type','xsd:string');
                                    xmlW.writeCharacters(collectionsearchparameterMap.get('SEARCH_CONSUMER_SURNAME'));
                                xmlW.writeEndElement(); //close SEARCH_CONSUMER_SURNAME
                            }
                            //check if SEARCH_CONSUMER_NAME key exists in collectionsearchparameterMap and value is not null
                            if(collectionsearchparameterMap.containskey('SEARCH_CONSUMER_NAME') && collectionsearchparameterMap.get('SEARCH_CONSUMER_NAME') != ''){
                                xmlW.writeStartElement('xsd','element', '');
                                xmlW.writeAttribute(null,null,'name','SEARCH_CONSUMER_NAME');
                                xmlW.writeAttribute(null,null,'minOccurs','0');
                                xmlW.writeAttribute(null,null,'type','xsd:string');
                                    xmlW.writeCharacters(collectionsearchparameterMap.get('SEARCH_CONSUMER_NAME'));
                                xmlW.writeEndElement(); //close SEARCH_CONSUMER_NAME
                            }
                        
                            xmlW.writeStartElement('xsd','element', '');
                            xmlW.writeAttribute(null,null,'name','SEARCH_ADDRESS');
                                xmlW.writeStartElement('xsd','complexType', '');
                                    xmlW.writeStartElement('xsd','all', '');
                                    //check if CONSUMER_STREET key exists in collectionsearchparameterMap and value is not null
                                    if(collectionsearchparameterMap.containskey('CONSUMER_STREET') && collectionsearchparameterMap.get('CONSUMER_STREET') != ''){
                                        xmlW.writeStartElement('xsd','element', '');
                                        xmlW.writeAttribute(null,null,'name','CONSUMER_STREET');
                                        xmlW.writeAttribute(null,null,'minOccurs','0');
                                        xmlW.writeAttribute(null,null,'type','xsd:string');
                                            xmlW.writeCharacters(collectionsearchparameterMap.get('CONSUMER_STREET'));
                                        xmlW.writeEndElement(); //close CONSUMER_STREET
                                    }
                                    //check if CONSUMER_CITY key exists in collectionsearchparameterMap and value is not null
                                    if(collectionsearchparameterMap.containskey('CONSUMER_CITY') && collectionsearchparameterMap.get('CONSUMER_CITY') != ''){
                                        xmlW.writeStartElement('xsd','element', '');
                                        xmlW.writeAttribute(null,null,'name','CONSUMER_CITY');
                                        xmlW.writeAttribute(null,null,'minOccurs','0');
                                        xmlW.writeAttribute(null,null,'type','xsd:string');
                                            xmlW.writeCharacters(collectionsearchparameterMap.get('CONSUMER_CITY'));
                                        xmlW.writeEndElement(); //close CONSUMER_CITY
                                    }
                                    //check if CONSUMER_STATE key exists in collectionsearchparameterMap and value is not null
                                    if(collectionsearchparameterMap.containskey('CONSUMER_STATE') && collectionsearchparameterMap.get('CONSUMER_STATE') != ''){
                                        xmlW.writeStartElement('xsd','element', '');
                                        xmlW.writeAttribute(null,null,'name','CONSUMER_STATE');
                                        xmlW.writeAttribute(null,null,'minOccurs','0');
                                        xmlW.writeAttribute(null,null,'type','xsd:string');
                                            xmlW.writeCharacters(collectionsearchparameterMap.get('CONSUMER_STATE'));
                                        xmlW.writeEndElement(); //close CONSUMER_STATE
                                    }
                                    //check if CONSUMER_ZIP key exists in collectionsearchparameterMap and value is not null
                                    if(collectionsearchparameterMap.containskey('CONSUMER_ZIP') && collectionsearchparameterMap.get('CONSUMER_ZIP') != ''){
                                        xmlW.writeStartElement('xsd','element', '');
                                        xmlW.writeAttribute(null,null,'name','CONSUMER_ZIP');
                                        xmlW.writeAttribute(null,null,'minOccurs','0');
                                        xmlW.writeAttribute(null,null,'type','xsd:string');
                                            xmlW.writeCharacters(collectionsearchparameterMap.get('CONSUMER_ZIP'));
                                        xmlW.writeEndElement(); //close CONSUMER_ZIP
                                    }
                                    xmlW.writeEndElement(); //close all 
                                xmlW.writeEndElement(); //close complextype             
                            xmlW.writeEndElement(); //close SEARCH_ADDRESS
                            
                            
                            
                            xmlW.writeStartElement('xsd','element', '');
                            xmlW.writeAttribute(null,null,'name','SEARCH_ID');
                                xmlW.writeStartElement('xsd','complexType', '');
                                    xmlW.writeStartElement('xsd','all', '');
                                    //check if PassportNo key exists in collectionsearchparameterMap and value is not null
                                    if(collectionsearchparameterMap.containskey('PassportNo') && collectionsearchparameterMap.get('PassportNo') != ''){
                                        xmlW.writeStartElement('xsd','element', '');
                                        xmlW.writeAttribute(null,null,'name','PassportNo');
                                        xmlW.writeAttribute(null,null,'minOccurs','0');
                                        xmlW.writeAttribute(null,null,'type','xsd:string');
                                            xmlW.writeCharacters(collectionsearchparameterMap.get('PassportNo'));
                                        xmlW.writeEndElement(); //close PassportNo
                                    }
                                    //check if SSN key exists in collectionsearchparameterMap and value is not null
                                    if(collectionsearchparameterMap.containskey('SSN') && collectionsearchparameterMap.get('SSN') != ''){
                                        xmlW.writeStartElement('xsd','element', '');
                                        xmlW.writeAttribute(null,null,'name','SSN');
                                        xmlW.writeAttribute(null,null,'minOccurs','0');
                                        xmlW.writeAttribute(null,null,'type','xsd:string');
                                            xmlW.writeCharacters(collectionsearchparameterMap.get('SSN'));
                                        xmlW.writeEndElement(); //close SSN
                                    }
                                    //check if DrivingLicense key exists in collectionsearchparameterMap and value is not null
                                    if(collectionsearchparameterMap.containskey('DrivingLicense') && collectionsearchparameterMap.get('DrivingLicense') != ''){
                                        xmlW.writeStartElement('xsd','element', '');
                                        xmlW.writeAttribute(null,null,'name','DrivingLicense');
                                        xmlW.writeAttribute(null,null,'minOccurs','0');
                                        xmlW.writeAttribute(null,null,'type','xsd:string');
                                            xmlW.writeCharacters(collectionsearchparameterMap.get('DrivingLicense'));
                                        xmlW.writeEndElement(); //close DrivingLicense
                                    }
                                    
                                    xmlW.writeEndElement(); //close all (SEARCH_ID)
                                xmlW.writeEndElement(); //close complextype (SEARCH_ID)         
                            xmlW.writeEndElement(); //close SEARCH_ID
                        
                        xmlW.writeEndElement(); //close all (collections_search)
                    xmlW.writeEndElement(); //close complextype (collections_search)
                xmlW.writeEndElement(); //close collections_search
            xmlW.writeEndElement(); //close schema
        xmlW.writeEndDocument(); //Close XML document

    collectionsearchXMLRequest = xmlW.getXmlString();
    //System.debug('@@@@@@@@@@@@@@@@@@@@@'+xmlW.getXmlString());     
    xmlW.close();
            
    return collectionsearchXMLRequest; 
    }
    
    //Collection Search Interface response 
    public static CollectionResponseWrapper generateCollectionSearchResponse (string collectionsearchXMLResponse){
        CollectionResponseWrapper collectionResponseWrapperObj;
        List<Collectionwrapper>  CollectionwrapperList = new List<Collectionwrapper>();
        boolean isSafeToGetNextXmlElement = true;
        XmlStreamReader reader = new XmlStreamReader(collectionsearchXMLResponse);
        String RETURN_CODE = '';
        String RETURN_MSG = '';
        String MORE_RECS_AVAIL = '';
        
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if ('RETURN_CODE' == reader.getAttributeValue(null, 'name')) {
                    RETURN_CODE = parseString(reader);
                }
                else if ('RETURN_MSG' == reader.getAttributeValue(null, 'name')) {
                    RETURN_MSG = parseString(reader);
                }
                
                else if ('MORE_RECS_AVAIL' == reader.getAttributeValue(null, 'name')) {
                    MORE_RECS_AVAIL = parseString(reader);
                }
                
                //System.debug('^^^^' + reader.getLocalName());
                else if ('COLLECTION_RECORD' == reader.getAttributeValue(null, 'name')) {
                    System.debug('^^^^' + reader.getAttributeValue(null, 'name'));
                    Collectionwrapper  CollectionwrapperObj = parseCollectionwrapper(reader);
                    System.debug('@@@@@@CollectionwrapperObj '+CollectionwrapperObj);
                    CollectionwrapperList.add(CollectionwrapperObj);
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
        
        collectionResponseWrapperObj = new CollectionResponseWrapper(RETURN_CODE, RETURN_MSG, MORE_RECS_AVAIL, CollectionwrapperList);
        return collectionResponseWrapperObj; 
    }
    
//-------------------------------------------------support methods----------------------------------------------------------    
    public static Collectionwrapper parseCollectionwrapper(XmlStreamReader reader) {
        Collectionwrapper   collectionwrapperObj = new Collectionwrapper();
        boolean isSafeToGetNextXmlElement = true;

        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                isSafeToGetNextXmlElement = false;  
                   break;
            }
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                //System.debug('****' + reader.getLocalName() + '~~~~' + reader.getNamespace());
                if ('CONSUMER_GIVEN_NAME' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_GIVEN_NAME = parseString(reader);
                        System.debug('@@@@@@@@@@CONSUMER_GIVEN_NAME '+CONSUMER_GIVEN_NAME);
                        collectionwrapperObj.CONSUMER_GIVEN_NAME  =  Integer.valueOf(CONSUMER_GIVEN_NAME);
                }
                
            }
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                //System.debug('****' + reader.getLocalName() + '~~~~' + reader.getNamespace());
                if ('CONSUMER_SURNAME' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_SURNAME = parseString(reader);
                        collectionwrapperObj.CONSUMER_SURNAME = CONSUMER_SURNAME;
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

        return collectionwrapperObj;

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
    public class CollectionResponseWrapper{
    public string responsecode {get;set;}
    public string responsemsg {get;set;}
    public string morerecavailmsg {get;set;}
    
    public List<Collectionwrapper> collectionwrapperList {get;set;}
        public CollectionResponseWrapper(string responsecode , string responsemsg , string morerecavailmsg, List<Collectionwrapper> collectionwrapperList){
            this.responsecode = responsecode;
            this.responsemsg = responsemsg;
            this.morerecavailmsg = morerecavailmsg;
            this.collectionwrapperList = collectionwrapperList;
        }
    }
    
   
    public class Collectionwrapper{
    public Integer CONSUMER_GIVEN_NAME {get;set;}
    public string CONSUMER_SURNAME {get;set;}
    }   

}