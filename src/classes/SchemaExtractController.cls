public class SchemaExtractController {
/* simple logging */
    List<String> logMessages = new List<String>(); 
    public string[] log { get { return logMessages; } } 
    public integer logLen { get { return logMessages.size(); }}

    // manage the session token from a querystring param
    public string authToken { public get { 
        return ApexPages.currentPage().getParameters().get('sesstoken');
    } private set; }

    // manage user selections for sheet name and object name
    public string selectedSheet {get; set;}
    public string sheetUrl { get {return 'http://spreadsheets.google.com/ccc?key='+selectedSheet; }}
    
    public List<SelectOption> getSpreadSheets() {
        
        List<SelectOption> options = new List<SelectOption>();
        if ( authToken == null ) return options;
        
        SpreadsheetService service = new SpreadsheetService();  
        service.setAuthSubToken( this.authToken );  
        GoogleData sheets = service.getSpreadsheets(); 
        
        String idVal;
        String[] tokens;
        if(sheets != null){
            for(xmldom.element entry: sheets.entries){
                idVal = entry.getElementByTagName('id').nodeValue;
                tokens = idVal.split('/');
                idVal = tokens[tokens.size()-1];
                options.add(new SelectOption(idVal,
                                entry.getElementByTagName('title').nodeValue)
                            );
            }
        }
        return options;
    }

    
    public string selectedObject { get; set; }  
    public List<SelectOption> ObjectList { get {        
        List<SelectOption> options = new List<SelectOption>();
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        for(String name:schemaMap.keySet()){
            options.add(new SelectOption(name,name));// availObjList.add(name); 
        } 
        return options;
    }}

    // wizard navigation steps
    public PageReference continuePage() {return null;   }
    public PageReference extractMore(){
        extract();
        return null;
    }
    
    // main routines to query meta data and generate google sheet
    public void extract(){
        
        try{
            logMessages.clear(); 
            Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.DescribeSObjectResult descRes;
            Map<String, Schema.SObjectField> fieldMap ;     
        
            SpreadsheetService service = new SpreadsheetService();  
            service.setAuthSubToken(this.authToken);  
            logMessages.add('Extract to Selected Sheet Id= '+ this.SelectedSheet);
        
            xmldom.element oneSpreadSheet = service.getSpreadsheetById( this.SelectedSheet ); 
            
            String name = selectedObject; 
            descRes = schemaMap.get(name).getDescribe();
            fieldMap = descRes.fields.getMap();
            xmldom.element wrkSheet = new xmldom.element('entry');
            xmldom.element title = new xmldom.element('title') ;        
            title.nodeValue = name;
            wrkSheet.appendChild( title );
        
            xmldom.element rc = new xmldom.element('gs:rowCount');
            rc.nodeValue = String.valueOf(fieldMap.values().size() + 5);
            wrkSheet.appendChild( rc);  
            xmldom.element cc = new xmldom.element('gs:colCount');
            cc.nodeValue = '15';
            wrkSheet.appendChild( cc);  
            
            GoogleData.Worksheet addedWorkSheet = new GoogleData.Worksheet( wrkSheet);
            addedWorkSheet = service.insertWorksheet( oneSpreadSheet , addedWorkSheet );
            logMessages.add(name+':worksheet created'); 
        
            if ( extractObjectMetaData(name,service,addedWorksheet,fieldMap)){
                logMessages.add('[SUCCESS] Object '+name+': Extract Successful');   
            } else {
                logMessages.add('[FAILED] Object '+name+': Extract Failed. !!!');   
            }
            
        } catch( Exception ex ){
            logMessages.add(ex.getMessage());
        }
    }   
    
    private boolean extractObjectMetaData(  String name,
                                        SpreadSheetService service,
                                        GoogleData.Worksheet wrkSheet,
                                        Map<String, Schema.SObjectField> fieldMap)
    {
        
        
        string cellFeedUrl = wrkSheet.getCellFeedUrl();
        // specify range to avoid data overflow
        Integer totFields = fieldMap.values().size(); 
        Integer fldsPerBatch = 20;
        GoogleData feed;
        GoogleData.Cell cell;
        Integer startIndex=1,endIndex=1;
        if(fieldMap.keySet().size()> fldsPerBatch){
            startIndex=1;
            endIndex=fldsPerBatch+1;
        }else{
            startIndex=1;
            endIndex=totFields+1;
        }
        logMessages.add('['+name+']: Fetching Cell Range: start='+startIndex+',end='+endIndex);
        try{
            feed = service.getFeedRange( cellFeedUrl ,'R'+startIndex+'C1:R'+endIndex+'C5');
        }catch(Exception ex){
            system.debug('['+name+']:ERROR:'+ex.getMessage());
            return false;   
        }   
        logMessages.add('['+name+']: feed is null '+(feed == null));
        Map<String,GoogleData.Cell> cellMap = wrkSheet.cellFactoryAsMap( feed.entries );  
        if(startIndex == 1){
            cell = cellMap.get('R1C1');
            if(cell != null)
                cell.content = 'Field Label';
            
            cell = cellMap.get('R1C2');
            if(cell != null)
                cell.content = 'Datatype';
    
            cell = cellMap.get('R1C3');
            if(cell != null)
                cell.content = 'Picklist Values';
    
            cell = cellMap.get('R1C4');
            if(cell != null)
                cell.content = 'Field Properties';
            
            cell = cellMap.get('R1C5');
            if(cell != null)
                cell.content = 'API Field Name';
        }       
        Integer currRow=1,curNbrFlds=1;
        Schema.DescribeFieldResult fldDescRes;
        List <Schema.PicklistEntry> pickValList;
        String tempStr,currFldName;

        try{
            for(String fldName: fieldMap.keySet()){
                currFldName = fldName;
                currRow++;
                curNbrFlds++;
                fldDescRes = fieldMap.get(fldName).getDescribe();
                cell = cellMap.get('R'+currRow+'C1');
                //logMessages.add('['+name+'] Got cell for row#'+currRow+', isNull='+(cell ==null)); 
                cell.content = fldDescRes.getLabel();
        
                cell = cellMap.get('R'+currRow+'C2');
                tempStr = fldDescRes.getType()+'';
                tempStr = tempStr.replace('.',';');
                List<String> tokens = tempStr.split(';');
                if(tokens.size() == 3){
                    tempStr = tokens[2];    
                }
                if(fldDescRes.getType() == Schema.DisplayType.String ){
                    cell.content = tempStr+'('+fldDescRes.getLength()+')';
                }else{
                    cell.content = tempStr;
                } 
    
                cell = cellMap.get('R'+currRow+'C3');
                if(fldDescRes.getType() == Schema.DisplayType.Picklist){
                    pickValList = fldDescRes.getPicklistValues();
                    if(pickValList!= null && pickValList.size() >0){
                        tempStr='';
                        for(Schema.PicklistEntry entry:pickValList){
                            if(entry.isActive()){
                                tempStr+=entry.getLabel()+',';  
                            }
                        }
                        if(cell != null){
                            tempStr = tempStr.replace('&','\'');
                            cell.content = tempStr;
                        }
                    }
                }
    
                cell = cellMap.get('R'+currRow+'C4');
                tempStr ='';
                if(fldDescRes.isNillable()){
                    tempStr +='Required';
                }
                if(cell != null)
                    cell.content = tempStr;
    
                cell = cellMap.get('R'+currRow+'C5');
                if(cell != null)
                    cell.content = fldDescRes.getName();
                
                if(curNbrFlds == fldsPerBatch){
                    if(totFields < currRow){
                        break;
                    }
                    service.updateCells(wrkSheet,cellMap.values());
                    curNbrFlds=0;
                    /*
                    logMessages.add('['+name+']: currRow='+currRow);
                    logMessages.add('['+name+']: (currRow+fldsPerBatch)='+(currRow+fldsPerBatch));
                    logMessages.add('['+name+']: totFields='+totFields);
                    */
                    if(totFields > (currRow+fldsPerBatch)){
                        startIndex = currRow+1;
                        endIndex = currRow+1+fldsPerBatch;
                    }else{
                        startIndex = currRow+1;
                        endIndex = totFields+1;
                    }
                    feed = service.getFeedRange( cellFeedUrl ,'R'+startIndex+'C1:R'+endIndex+'C5');
                    //logMessages.add('['+name+']: Got new range of cells.....');
                    cellMap = wrkSheet.cellFactoryAsMap( feed.entries );  
                        
                }
                logMessages.add('['+name+']: Completed Processing Field:'+fldName);
            }
            logMessages.add('['+name+']: Calling for remaining fields...');
            logMessages.add('['+name+']: cellMap is null:'+(cellMap == null));
            service.updateCells(wrkSheet,cellMap.values());
            logMessages.add('['+name+']: Status Code:'+service.response.getStatusCode());
            
        }catch(Exception ex){
            logMessages.add('['+name+']:ERROR: currFldName='+currFldName+',currRow='+currRow);
            system.debug('['+name+']:ERROR:'+ex.getMessage());
            //throw ex;
            return false;   
        }
        logMessages.add('['+name+']: Completed All Fields');
        return true;
    }
    
   
    
}