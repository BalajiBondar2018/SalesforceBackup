public class AuthService{
	//Auth Search Interface response 
    public static AuthResponseWrapper generateAuthSearchResponse (string AuthsearchXMLResponse){
        AuthResponseWrapper AuthResponseWrapperObj;
        List<LinkedIdNeg1Levelwrapper>  LinkedIdNeg1LevelwrapperList = new List<LinkedIdNeg1Levelwrapper>();
        boolean isSafeToGetNextXmlElement = true;
        XmlStreamReader reader = new XmlStreamReader(AuthsearchXMLResponse);
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
                else if ('LINKED_ID_NEG_1ST_LEVEL' == reader.getAttributeValue(null, 'name')) {
                    System.debug('^^^^' + reader.getAttributeValue(null, 'name'));
                    LinkedIdNeg1Levelwrapper  LinkedIdNeg1LevelwrapperObj = parseLinkedIdNeg1Levelwrapper(reader);
                    System.debug('@@@@@@AuthwrapperObj '+LinkedIdNeg1LevelwrapperObj);
                    LinkedIdNeg1LevelwrapperList.add(LinkedIdNeg1LevelwrapperObj);
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
        
        //AuthResponseWrapperObj = new AuthResponseWrapper(RETURN_CODE, RETURN_MSG, MORE_RECS_AVAIL, AuthwrapperList);
        return AuthResponseWrapperObj; 
    }
    
//-------------------------------------------------support methods----------------------------------------------------------    
    public static LinkedIdNeg1Levelwrapper parseLinkedIdNeg1Levelwrapper(XmlStreamReader reader) {
        LinkedIdNeg1Levelwrapper   LinkedIdNeg1LevelwrapperObj = new LinkedIdNeg1Levelwrapper();
        boolean isSafeToGetNextXmlElement = true;

        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                isSafeToGetNextXmlElement = false;  
                   break;
            }
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                //System.debug('****' + reader.getLocalName() + '~~~~' + reader.getNamespace());
                if ('CONSUMER_ID_TYPE' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_ID_TYPE = parseString(reader);
                        System.debug('@@@@@@@@@@CONSUMER_ID_TYPE '+CONSUMER_ID_TYPE);
                        LinkedIdNeg1LevelwrapperObj.CONSUMER_ID_TYPE  =  CONSUMER_ID_TYPE;
                }
            }
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                //System.debug('****' + reader.getLocalName() + '~~~~' + reader.getNamespace());
                if ('CONSUMER_ID_NUM' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_ID_NUM = parseString(reader);
                        LinkedIdNeg1LevelwrapperObj.CONSUMER_ID_NUM = CONSUMER_ID_NUM;
                }
            }
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                //System.debug('****' + reader.getLocalName() + '~~~~' + reader.getNamespace());
                if ('CONSUMER_ID_SUBTYPE' == reader.getAttributeValue(null, 'name')) {
                        String CONSUMER_ID_SUBTYPE = parseString(reader);
                        LinkedIdNeg1LevelwrapperObj.CONSUMER_ID_SUBTYPE = CONSUMER_ID_SUBTYPE;
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
	    return LinkedIdNeg1LevelwrapperObj;
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
    public class AuthResponseWrapper{
    public string responsecode {get;set;}
    public string responsemsg {get;set;}
    public string morerecavailmsg {get;set;}
    public List<SummaryInformationwrapper> SummaryInformationwrapperList {get;set;}
    public List<LinkedInformationSummaryRecordwrapper> LinkedInformationSummaryRecordwrapperList {get;set;}
    public List<LinkedInformationDetailedRecordwrapper> LinkedInformationDetailedRecordwrapperList {get;set;}
    public List<LinkedIdNeg1Levelwrapper> LinkedIdNeg1LevelwrapperList {get;set;}
    public List<LinkedId1Levelwrapper> LinkedId1LevelwrapperList {get;set;}
    public List<NegativeInformationwrapper> NegativeInformationwrapperList {get;set;}
    
    public AuthResponseWrapper(string responsecode , string responsemsg , string morerecavailmsg, List<SummaryInformationwrapper> SummaryInformationwrapperList,List<LinkedInformationSummaryRecordwrapper> LinkedInformationSummaryRecordwrapperList,List<LinkedInformationDetailedRecordwrapper> LinkedInformationDetailedRecordwrapperList,List<LinkedIdNeg1Levelwrapper> LinkedIdNeg1LevelwrapperList,List<LinkedId1Levelwrapper> LinkedId1LevelwrapperList, List<NegativeInformationwrapper> NegativeInformationwrapperList){
        this.responsecode = responsecode;
        this.responsemsg = responsemsg;
        this.morerecavailmsg = morerecavailmsg;
        this.SummaryInformationwrapperList = SummaryInformationwrapperList;
        this.LinkedInformationSummaryRecordwrapperList = LinkedInformationSummaryRecordwrapperList;
        this.LinkedInformationDetailedRecordwrapperList = LinkedInformationDetailedRecordwrapperList;
        this.LinkedIdNeg1LevelwrapperList = LinkedIdNeg1LevelwrapperList;
        this.LinkedId1LevelwrapperList =LinkedId1LevelwrapperList;
        this.NegativeInformationwrapperList = NegativeInformationwrapperList;
        }
    }
    
    public class SummaryInformationwrapper{
        public Integer CONSUMER_GIVEN_NAME {get;set;}
        public string CONSUMER_SURNAME {get;set;}
    }
    
    public class LinkedInformationSummaryRecordwrapper{
        public Integer CONSUMER_GIVEN_NAME {get;set;}
        public string CONSUMER_SURNAME {get;set;}
    }
    
    public class LinkedInformationDetailedRecordwrapper{
        public Integer CONSUMER_GIVEN_NAME {get;set;}
        public string CONSUMER_SURNAME {get;set;}
    }
    
    public class LinkedIdNeg1Levelwrapper{
	    public string CONSUMER_ID_TYPE {get;set;}
	    public string CONSUMER_ID_SUBTYPE {get;set;}
	    public string CONSUMER_ID_NUM {get;set;}
    }
    
    public class LinkedId1Levelwrapper{
	    public string CONSUMER_ID_TYPE {get;set;}
	    public string CONSUMER_ID_SUBTYPE {get;set;}
	    public string CONSUMER_ID_NUM {get;set;}
    }
    
    public class NegativeInformationwrapper{
        public string DISPUTE_STATUS {get;set;}
        public string DEBT_TYPE {get;set;}
        public string DEBT_REASON {get;set;}
        public string DEBT_SUBSCRIBER {get;set;}
        public string DEBT_DATE {get;set;}
        public string DEBT_AMOUNT {get;set;}
        public string COLL_LOG_DEBT_CODE {get;set;}
        public string DEBT_EDIT_DATE {get;set;}
        public string DEBT_EDIT_BY {get;set;}
    }
    

}