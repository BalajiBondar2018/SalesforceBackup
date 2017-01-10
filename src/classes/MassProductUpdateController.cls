public class MassProductUpdateController {
//variables
public integer rowcount;//count to show the # of rows on the table
public string selectedParameter{get;set;}//selected parameter
public string nameFile{get;set;}//uploaded file
public Blob contentFile{get;set;}//bolb content of file uploaded via upload button click
String[] filelines = new String[]{};//list of product records with operator and value
public boolean showsuccessMessageFlag{get;set;}//flag to show success msg on click on update button
Map<string,Id> productKeyIdMap = new Map<string,Id>();//map of product key and Product Ids
public Set<Id> ProductIdSet = new Set<Id>();//set of unique products to pass to batch apex
public Map<Id,String> ProductIdOperatorMap = new Map<Id,String>();//map of product and respective operator
public Map<Id,Decimal> ProductIdVariationMap = new Map<Id,Decimal>();//map of product and respective variation
   
        public List<ProductWrapper> ProductWrapperList = new List<ProductWrapper>();
public List<ProductWrapper> getProductWrapperList (){
    return ProductWrapperList;
}

public void setProductWrapperList (List<ProductWrapper> ProductWrapperList ){
    this.ProductWrapperList = ProductWrapperList ;
}

//-------------------------------Page Load-------------------------------------------------------------------
    public pagereference PageLoad(){
    selectedParameter = 'offerprice';
    ProductWrapperList  = GenerateBlankProductRow();
    showsuccessMessageFlag = false;
    return null;
    }
    
//-------------------------------Action Methods -------------------------------------------------------------
    public pagereference BackToHomeClick(){
    return null;
    }

    public pagereference AddRowsClick(){
    ProductWrapperList.addAll(GenerateBlankProductRow());
    return null;
    }
    //upload button click    
    public pagereference UploadBtnClick(){
    System.debug('Upload Button called.');
    ProductWrapperList.clear();
    List<string> productKeyList = new List<string>();
    try{ 
    nameFile=contentFile.toString();
    filelines = nameFile.split('\n');
        
        for (Integer count = 1; count < filelines.size(); count++){
            List<string> rowvalueList = new List<string>();
            rowvalueList = filelines[count].split(',');
            productKeyList.add(rowvalueList[0]);    
        }
        
        for(Product2 productObj : [select Id, Product_Key__c from Product2 where Product_Key__c IN :productKeyList LIMIT 1000]){
            //ProductIdSet.add(productObj.Id); 
            productKeyIdMap.put(productObj.Product_Key__c , productObj.Id);
        }    
        
            for (Integer count = 1; count < filelines.size(); count++){
                List<string> rowvalueList = new List<string>();
                rowvalueList = filelines[count].split(',');
       
                if(productKeyIdMap.containsKey(rowvalueList[0]) && rowvalueList[1] != null && rowvalueList[2] != null){
                    ProductWrapper ProductWrapperObj = new ProductWrapper(new Flexible_Contract_Price__c(product__c=productKeyIdMap.get(rowvalueList[0])));
                    ProductWrapperObj.Operator = rowvalueList[1]; 
                    ProductWrapperObj.value = Integer.valueof(rowvalueList[2].trim());
               
                    ProductWrapperList.add(ProductWrapperObj);
                }
            }
        }catch(Exception ex){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex+'Please contact to System Administrator.'));
        return null;
        }
    
    return null;
    }

    public pagereference UpdateBtnClick(){
    showsuccessMessageFlag = true;
    
    for(ProductWrapper ProductWrapperObj:ProductWrapperList){
    ProductIdSet.add(ProductWrapperObj.FCPObj.Product__c);
    ProductIdOperatorMap.put(ProductWrapperObj.FCPObj.Product__c,ProductWrapperObj.operator);
    ProductIdVariationMap.put(ProductWrapperObj.FCPObj.Product__c,ProductWrapperObj.value);
    }
    System.debug('------------------ProductIdSet '+ProductIdSet);
    System.debug('------------------ProductIdOperatorMap '+ProductIdOperatorMap);
    System.debug('------------------ProductIdVariationMap '+ProductIdVariationMap);
    
    if(ProductIdSet.size()>0)
    Id batchInstanceId = Database.executeBatch(new MassFCPsUpdateBatch(selectedParameter,ProductIdSet,ProductIdOperatorMap,ProductIdVariationMap), 2000); 
    
    ProductWrapperList.clear();
    ProductWrapperList  = GenerateBlankProductRow();
    
    productKeyIdMap.clear();
    ProductIdSet.clear();
    ProductIdOperatorMap.clear();
    ProductIdVariationMap.clear();  
    
    return null;
    }

    public pagereference CancelBtnClick(){
    ProductWrapperList.clear();
    showsuccessMessageFlag = false;
    ProductWrapperList  = GenerateBlankProductRow();
    return null;
    }
    
//-------------------------------Support Methods -------------------------------------------------------------
    public List<ProductWrapper> GenerateBlankProductRow(){
    List<ProductWrapper> ProductWrapperList = new List<ProductWrapper>();
        for(integer count=0;count<5;count++){
            ProductWrapperList.add(new ProductWrapper(new Flexible_Contract_Price__c()));
        }
    return ProductWrapperList;
    }
    
    //wrapper class
    public class ProductWrapper{
        public Flexible_Contract_Price__c FCPObj{get;set;}
        public string operator{get;set;}
        public Decimal value{get;set;}
        //constructor
        public ProductWrapper(Flexible_Contract_Price__c FCPObj){
        this.FCPObj= FCPObj;
        }
    }
     
}