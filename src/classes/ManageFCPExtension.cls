public class ManageFCPExtension {
public Contract contractObj{get;set;}//object to hold the contract Id, Name information
public Boolean showProductSearchResult{get;set;} //flag to show/hide the product search result
public Boolean showFCPListflag{get;set;}//flag to show/hide the avaliable FCP list
public String productCodeStr {get;set;}//Capture the product code entered for searching the region specific products
public List<Flexible_Contract_Price__c> updateFCPList = new List<Flexible_Contract_Price__c>();//list of fcp which needs to be updated
public string selecteddiscountparameter{get;set;}//selected discount parameter such as Q price or SSP
public string discountpercentage{get;set;}//User entered discount %

public string selectedmarginparameter{get;set;}//selected discount parameter such as Equal,Increase,Decrease
public string updatedmargin{get;set;}//User entered Margin %

public boolean selectAllProductsFlag{get;set;}//flag to capture the Select All Products checkbox
public boolean selectAllFCPsFlag{get;set;}//flag to capture the Select All FCP checkbox
public Map<Id, Flexible_Contract_Price__c> ProductIdFCPMap = new Map<Id, Flexible_Contract_Price__c>();//Map of Product Ids and Product records
public List<Product2> duplicateProductList = new List<Product2>(); //List of duplicate product records on click of Add button
    //property to store the Product wrapper records
    public List<productWrapper> productWrapperList = new List<productWrapper>(); 
    public List<productWrapper> getproductWrapperList(){
            return productWrapperList;
    }
    //property to store the FCP wrapper records
    public List<FCPWrapper> FCPWrapperList = new List<FCPWrapper>();
    public List<FCPWrapper> getFCPWrapperList(){
        return FCPWrapperList;
    }
    public void setFCPWrapperList(List<FCPWrapper> FCPWrapperList){
        this.FCPWrapperList = FCPWrapperList;
    }
    //Property to capture the End Date during Mass End Date update functionality
    public Flexible_Contract_Price__c FCPObj = new Flexible_Contract_Price__c(); 
    public Flexible_Contract_Price__c getFCPObj(){
        return FCPObj;
    }
    //Constructor
    public ManageFCPExtension(ApexPages.StandardController controller) {
    //System.debug('---------------------In Constructor.');
    contractObj = (Contract) controller.getRecord();
    contractObj = [select Id, ContractNumber from Contract where Id=:contractObj.Id LIMIT 1];
    selectAllProductsFlag = false;
    selectAllFCPsFlag = false;
    //Query all the contract related FCP records
    FetchFCPWrapperList();
    }
    
//------------------PageBlockSection-I Methods---------------------------
        //Back to Contract button click action
        public Pagereference BackBtnClick(){
        PageReference pageRef = new PageReference('/'+contractObj.Id);  
        pageRef.setRedirect(true);
        return pageRef;
        }
        //Search button click action : Search region specific products based on users entered product codes
        public Pagereference SearchBtnClick(){
        List<string> invalidProductCodeList = new List<string>();
        Set<string> productcodeSet = new Set<string>();
        //form a Map of already searched Product Id & Product
        Map <Id, Product2> productIdProductMap = new Map<Id, Product2>();
        //form a Map of Product Code & Product
        Map <String, Product2> productCodeProductMap = new Map<String, Product2>();
        
        
        selectAllProductsFlag = false;
        productWrapperList.clear();
        
        for(productWrapper productWrapperObj : productWrapperList)
            productIdProductMap.put(productWrapperObj.Product.Id,productWrapperObj.Product); 
        
        //Query all the region specific products based on Product Codes
        for(Product2 productObj : [Select  p.Name, p.ProductCode, p.Family,p.Cost_Price__c, p.Min_Price__c, p.Max_Price__c , p.S_Book__c, p.Q_Book__c, p.G_Book__c, Suggested_Price__c 
                                                                        From Product2 p where p.ProductCode IN :SeperateProductCodes(productCodeStr) order by p.Family LIMIT 100]){
            if(!productIdProductMap.ContainsKey(productObj.Id)){
                productWrapperList.add(new ProductWrapper(productObj));
                productCodeProductMap.put(productObj.ProductCode,productObj);
            }
        }
        /*
        //create a set of Product codes entered by User 
        for(string productcodestr : SeperateProductCodes(productCodeStr)){
            productcodeSet.add(productcodestr);
        }
        System.debug('--------------- User entered productcodeSet '+productcodeSet);
        System.debug('--------------- productCodeProductMap '+productCodeProductMap);
        
        //check if product code exists in the system or not
        if(productcodeSet.size()>0 || productcodeSet!=null){
            for(string productcodestr : productcodeSet){
                if(!productCodeProductMap.containsKey(productcodestr)){
                    invalidProductCodeList.add(productcodestr);
                }  
            }
            System.debug('--------------- InvalidProductCodeList '+invalidProductCodeList);
            
            //show the info message if system is not able to search for the product codes
            if(invalidProductCodeList.size()>0){
                ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.INFO, 'System is unable to search products.Product codes:'+FormatProductCodeString(invalidProductCodeList));
                ApexPages.addmessage(errormsg);
            }
        }
        */
        //set search product code to Null
        productCodeStr = Null;
        
        return null;
        }
        //Add button click action : Action will add all the selected products as FCP under contract
        public Pagereference AddBtnClick(){
        selectAllProductsFlag = false;
        selectAllFCPsFlag = false;
        List<Flexible_Contract_Price__c> newFCPList = new List<Flexible_Contract_Price__c>();
        Flexible_Contract_Price__c tempFCPObj;
        List<ProductWrapper> tempProductWrapperList = new List<ProductWrapper>();
        tempProductWrapperList.addAll(productWrapperList);
        duplicateProductList.clear();
        //Add all newly selected products to the existing FCP list                
        for(integer count = tempProductWrapperList.size()-1; count>=0; count--){
        tempFCPObj = new Flexible_Contract_Price__c();
            if(tempProductWrapperList[count].isselected == true){
                tempFCPObj.Contract__c = contractObj.Id;
                tempFCPObj.Product__c = tempProductWrapperList[count].product.Id;
                tempFCPObj.Q_Book__c = tempProductWrapperList[count].product.Q_Book__c;
                tempFCPObj.S_Book__c = tempProductWrapperList[count].product.S_Book__c;
                tempFCPObj.G_Book__c = tempProductWrapperList[count].product.G_Book__c;
                tempFCPObj.Suggested_Price__c = tempProductWrapperList[count].product.Suggested_Price__c;
                tempFCPObj.End_Date__c = System.today() + 90;
                //insert a new FCP if FCP doesn't exists in the already added FCP list
                if(!ProductIdFCPMap.ContainsKey(tempFCPObj.Product__c)) newFCPList.add(tempFCPObj);
                else duplicateProductList.add(tempProductWrapperList[count].Product);
                //remove the added products as fcp from the Product search list
                productWrapperList.remove(count);
            }
        }
        insert newFCPList;
        
        if(duplicateProductList.size()>0){
            List<string> duplicateproductcodeList = new LIst<string>();
            for(Product2 productObj : duplicateProductList){
                    duplicateproductcodeList.add(productObj.ProductCode);
                    FormatProductCodeString(duplicateproductcodeList);
             }
            if(duplicateproductcodeList.size()>0){
                ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.INFO, 'These products are already exists under contract and will not be added as FCP.Product codes:'+FormatProductCodeString(duplicateproductcodeList));
                ApexPages.addmessage(errormsg);
            }
        }
        
        FCPWrapperList.clear();
        FetchFCPWrapperList();
        getFCPWrapperList();
            
        return null;
        } 

        public Pagereference CancelBtnClick(){
        selectAllProductsFlag = false;
        selectAllFCPsFlag = false;

        for(productWrapper productwrapperObj : productWrapperList){
            if(productwrapperObj.isselected == true) productwrapperObj.isselected = false;
        }
        
        return null;
        } 

//------------------PageBlockSection-II Methods-------------------------------------------------------------------
    public Pagereference DeleteBtnClick(){
    List<Flexible_Contract_Price__c> deleteFCPList = new List<Flexible_Contract_Price__c>();    
    for(Integer i=0;i<FCPWrapperList.size();i++){
        if(FCPWrapperList[i].isselected == true)           
            deleteFCPList.add(FCPWrapperList[i].flexiblecontractprice);
        }
    delete deleteFCPList;
    FCPWrapperList.clear();
    ProductIdFCPMap.clear();
    FetchFCPWrapperList();
    getFCPWrapperList();
    selectAllFCPsFlag = false;
    return null;
    } 
    
    public Pagereference ActivateBtnClick(){
        //FCPs required information validation
        List<string> errorrequiredinformationproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && (fcpwrapperObj.flexiblecontractprice.End_Date__c == Null || fcpwrapperObj.flexiblecontractprice.Start_Date__c == Null || fcpwrapperObj.flexiblecontractprice.Sales_Price__c == Null)){            
                errorrequiredinformationproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorrequiredinformationproductcodeList);
            }
        }
        if(errorrequiredinformationproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date,End Date & Offer Price are required before activating the FCPs.Product codes:'+FormatProductCodeString(errorrequiredinformationproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //FCP Dates validation
        List<string> errorproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.End_Date__c < fcpwrapperObj.flexiblecontractprice.Start_Date__c ){            
                errorproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeList);
            }
        }
        if(errorproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'End date should be greater than Start date.Product Codes:'+FormatProductCodeString(errorproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //validate: Start Date & End Date difference should not be greater than 365 days
        List<string> errorproductcodeforenddateList = new List<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true &&  fcpwrapperObj.flexiblecontractprice.Start_Date__c.daysBetween(fcpwrapperObj.flexiblecontractprice.End_Date__c)> 365){            
                errorproductcodeforenddateList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeforenddateList);
            }
        }
        if(errorproductcodeforenddateList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date & End Date difference should not be greater than one year.Product Codes:'+FormatProductCodeString(errorproductcodeforenddateList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //FCPs offerprice validation
        List<string> errorproductcodeforOfferpriceList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && (fcpwrapperObj.flexiblecontractprice.Sales_Price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c || fcpwrapperObj.flexiblecontractprice.Sales_Price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c)){            
                errorproductcodeforOfferpriceList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
            }
        }
        if(errorproductcodeforOfferpriceList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Sales Price Should be greater than Min Price and less than Max Price.Product Codes:'+FormatProductCodeString(errorproductcodeforOfferpriceList));
            ApexPages.addmessage(errormsg); 
            return null;
        }
        
        updateFCPList.clear();  
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.status__c != 'Activated'){
                    fcpwrapperObj.flexiblecontractprice.status__c = 'Activated';
                    updateFCPList.add(fcpwrapperObj.flexiblecontractprice);
            }
        }
        update updateFCPList;
        
        FCPWrapperList.clear();
        FetchFCPWrapperList();
        getFCPWrapperList();
        selectAllFCPsFlag = false;
        return null;
    }
 
    public Pagereference DeActivateBtnClick(){
        //FCP Dates validation
        List<string> errorproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.End_Date__c < fcpwrapperObj.flexiblecontractprice.Start_Date__c ){            
                errorproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeList);
            }
        }
        if(errorproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'End Date should be greater than Start Date.Product Codes:'+FormatProductCodeString(errorproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //validate: Start Date & End Date difference should not be greater than 365 days
        List<string> errorproductcodeforenddateList = new List<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true &&  fcpwrapperObj.flexiblecontractprice.Start_Date__c.daysBetween(fcpwrapperObj.flexiblecontractprice.End_Date__c)> 365){            
                errorproductcodeforenddateList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeforenddateList);
            }
        }
        if(errorproductcodeforenddateList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date & End Date difference should not be greater than one year.Product Codes:'+FormatProductCodeString(errorproductcodeforenddateList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //FCPs offerprice validation
        List<string> errorproductcodeforOfferpriceList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && (fcpwrapperObj.flexiblecontractprice.Sales_Price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c || fcpwrapperObj.flexiblecontractprice.Sales_Price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c)){            
                errorproductcodeforOfferpriceList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
            }
        }
        if(errorproductcodeforOfferpriceList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Offer Price Should be greater than Min Price and less than Max Price.Product Codes:'+FormatProductCodeString(errorproductcodeforOfferpriceList));
            ApexPages.addmessage(errormsg); 
            return null;
        }   
        
        updateFCPList.clear();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.status__c != 'Deactivated'){
                fcpwrapperObj.flexiblecontractprice.status__c = 'Deactivated';
                updateFCPList.add(fcpwrapperObj.flexiblecontractprice);
            }
        }
        update updateFCPList;
        
        FCPWrapperList.clear();
        FetchFCPWrapperList();
        getFCPWrapperList();
        selectAllFCPsFlag = false;
    return null;
    }


    public Pagereference ConfirmMassOfferPriceUpdateBtnClick(){
        //FCP Dates validation
        List<string> errorproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.End_Date__c < fcpwrapperObj.flexiblecontractprice.Start_Date__c ){            
                errorproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeList);
            }
        }
        if(errorproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'End date should be greater than Start Date.Product Codes:'+FormatProductCodeString(errorproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //validate: Start Date & End Date difference should not be greater than 365 days
        List<string> errorproductcodeforenddateList = new List<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true &&  fcpwrapperObj.flexiblecontractprice.Start_Date__c.daysBetween(fcpwrapperObj.flexiblecontractprice.End_Date__c)> 365){            
                errorproductcodeforenddateList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeforenddateList);
            }
        }
        if(errorproductcodeforenddateList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date & End Date difference should not be greater than one year.Product Codes:'+FormatProductCodeString(errorproductcodeforenddateList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //FCPs offerprice validation
        List<string> errorproductcodeforOfferpriceList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && (fcpwrapperObj.flexiblecontractprice.Sales_Price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c || fcpwrapperObj.flexiblecontractprice.Sales_Price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c)){            
                errorproductcodeforOfferpriceList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
            }
        }
        if(errorproductcodeforOfferpriceList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Offer Price Should be greater than min price and less than max price.Product Codes:'+FormatProductCodeString(errorproductcodeforOfferpriceList));
            ApexPages.addmessage(errormsg); 
            return null;
        }   
        
        updateFCPList.clear();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.mass_price_change__c== true){
                    fcpwrapperObj.flexiblecontractprice.mass_price_change__c = false ;
                    fcpwrapperObj.flexiblecontractprice.mass_price_change_Date__c = Null ;
                    updateFCPList.add(fcpwrapperObj.flexiblecontractprice);
            }
        }
        update updateFCPList;
        
        FCPWrapperList.clear();
        FetchFCPWrapperList();
        getFCPWrapperList();
        selectAllFCPsFlag = false;
        return null;
    }
    
        
    public Pagereference SaveBtnClick(){
        //FCP Dates validation
        List<string> errorproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.End_Date__c < fcpwrapperObj.flexiblecontractprice.Start_Date__c ){            
                errorproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeList);
            }
        }
        if(errorproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'End date should be greater than Start date.Product Codes:'+FormatProductCodeString(errorproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //validate: Start Date & End Date difference should not be greater than 365 days
        List<string> errorproductcodeforenddateList = new List<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true &&  fcpwrapperObj.flexiblecontractprice.Start_Date__c.daysBetween(fcpwrapperObj.flexiblecontractprice.End_Date__c)> 365){            
                errorproductcodeforenddateList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeforenddateList);
            }
        }
        if(errorproductcodeforenddateList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date & End Date difference should not be greater than one year.Product Codes:'+FormatProductCodeString(errorproductcodeforenddateList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //FCPs offerprice validation
        List<string> errorproductcodeforOfferpriceList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && (fcpwrapperObj.flexiblecontractprice.Sales_Price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c || fcpwrapperObj.flexiblecontractprice.Sales_Price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c)){            
                errorproductcodeforOfferpriceList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
            }
        }
        if(errorproductcodeforOfferpriceList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Offer Price Should be greater than Min price and less than Max price.Product Codes:'+FormatProductCodeString(errorproductcodeforOfferpriceList));
            ApexPages.addmessage(errormsg); 
            return null;
        }    
        
        //FCPs required information validation for FCPs with 'Activated' status
        List<string> errorrequiredinformationproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.status__c == 'Activated' && (fcpwrapperObj.flexiblecontractprice.End_Date__c == Null || fcpwrapperObj.flexiblecontractprice.Start_Date__c == Null || fcpwrapperObj.flexiblecontractprice.Sales_Price__c == Null)){            
                errorrequiredinformationproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorrequiredinformationproductcodeList);
            }
        }
        if(errorrequiredinformationproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date,End Date & Offer Price are required for Activated FCPs.Product codes:'+FormatProductCodeString(errorrequiredinformationproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        
        updateFCPList.clear();
        //update the offerprice & margin values for selected FCPs
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true){
                if(fcpwrapperObj.flexiblecontractprice.Margin2__c == Null)
                    fcpwrapperObj.flexiblecontractprice.Margin2__c = 0.0;
                else
                    fcpwrapperObj.flexiblecontractprice.Margin2__c = Double.valueOf(fcpwrapperObj.flexiblecontractprice.Margin2__c);       
                
                updateFCPList.add(fcpwrapperObj.flexiblecontractprice);
            }
        }
        update updateFCPList;
    
        FCPWrapperList.clear();
        FetchFCPWrapperList();
        getFCPWrapperList();
        selectAllFCPsFlag = false;
        return null;
    }
 
    public Pagereference SelectedFCPCancelBtnClick(){
        FCPWrapperList.clear();
        FetchFCPWrapperList();
        getFCPWrapperList();
        selectAllFCPsFlag = false;
        return null;
    } 
 
    public Pagereference EndDateMassUpdateBtnClick(){
        //FCP Dates validation
        List<string> errorproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && FCPObj.End_Date__c < fcpwrapperObj.flexiblecontractprice.Start_Date__c ){            
                errorproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeList);
            }
        }
        if(errorproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'End date should be greater than Start date.Product Codes:'+FormatProductCodeString(errorproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        
        //validate: Start Date & End Date difference should not be greater than 365 days
        List<string> errorproductcodeforenddateList = new List<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true &&  fcpwrapperObj.flexiblecontractprice.Start_Date__c.daysBetween(FCPObj.End_Date__c)> 365){            
                errorproductcodeforenddateList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeforenddateList);
            }
        }
        if(errorproductcodeforenddateList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date & End Date difference should not be greater than one year.Product Codes:'+FormatProductCodeString(errorproductcodeforenddateList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //FCPs offerprice validation
        List<string> errorproductcodeforOfferpriceList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && (fcpwrapperObj.flexiblecontractprice.Sales_Price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c || fcpwrapperObj.flexiblecontractprice.Sales_Price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c)){            
                errorproductcodeforOfferpriceList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
            }
        }
        if(errorproductcodeforOfferpriceList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Offer Price Should be greater than min price and less than max price.Product Codes:'+FormatProductCodeString(errorproductcodeforOfferpriceList));
            ApexPages.addmessage(errormsg); 
            return null;
        }
        
        updateFCPList.clear();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true){            
                fcpwrapperObj.flexiblecontractprice.End_Date__c = FCPObj.End_Date__c;
                updateFCPList.add(fcpwrapperObj.flexiblecontractprice);
            }
        }
        update updateFCPList;
            
        FCPWrapperList.clear();
        FetchFCPWrapperList();
        getFCPWrapperList();
        selectAllFCPsFlag = false;
    
        selecteddiscountparameter = null;
        discountpercentage = null;
        selectedmarginparameter = null;
        updatedmargin = null;
        FCPObj.End_Date__c = null;
    
        return null;
    } 

    public Pagereference MarginMassUpdateBtnClick(){
        //FCP Dates validation
        List<string> errorproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.End_Date__c < fcpwrapperObj.flexiblecontractprice.Start_Date__c ){            
                errorproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeList);
            }
        }
        if(errorproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'End date should be greater than Start date.Product Codes:'+FormatProductCodeString(errorproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //validate: Start Date & End Date difference should not be greater than 365 days
        List<string> errorproductcodeforenddateList = new List<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true &&  fcpwrapperObj.flexiblecontractprice.Start_Date__c.daysBetween(fcpwrapperObj.flexiblecontractprice.End_Date__c)> 365){            
                errorproductcodeforenddateList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeforenddateList);
            }
        }
        if(errorproductcodeforenddateList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date & End Date difference should not be greater than one year.Product Codes:'+FormatProductCodeString(errorproductcodeforenddateList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
    //Logic to mass update the Margin
    updateFCPList.clear();
    for(FCPWrapper fcpwrapperObj : FCPWrapperList){
        if(fcpwrapperObj.isselected == true){            
            if(selectedmarginparameter == 'Equal'){
            fcpwrapperObj.flexiblecontractprice.margin2__c = Double.valueOf(updatedmargin);
            }
            else if(selectedmarginparameter == 'Increase'){
            fcpwrapperObj.flexiblecontractprice.margin2__c += Double.valueOf(updatedmargin);
            }
            else if(selectedmarginparameter == 'Decrease'){
            fcpwrapperObj.flexiblecontractprice.margin2__c -= Double.valueOf(updatedmargin);
            }
        System.debug('-------------------- fcpwrapperObj.flexiblecontractprice.margin2__c '+fcpwrapperObj.flexiblecontractprice.margin2__c);
        fcpwrapperObj.flexiblecontractprice.sales_price__c = fcpwrapperObj.flexiblecontractprice.Cost_Price__c *(100/(100-fcpwrapperObj.flexiblecontractprice.margin2__c));
        
        if(fcpwrapperObj.flexiblecontractprice.sales_price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c) fcpwrapperObj.flexiblecontractprice.sales_price__c = fcpwrapperObj.flexiblecontractprice.Min_Price__c;
        if(fcpwrapperObj.flexiblecontractprice.sales_price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c) fcpwrapperObj.flexiblecontractprice.sales_price__c = fcpwrapperObj.flexiblecontractprice.Max_Price__c;
        
        updateFCPList.add(fcpwrapperObj.flexiblecontractprice);
        }
    }
    update updateFCPList;
     
    FCPWrapperList.clear();
    FetchFCPWrapperList();
    getFCPWrapperList();
    selectAllFCPsFlag = false;
    
    selecteddiscountparameter = null;
    discountpercentage = null;
    selectedmarginparameter = null;
    updatedmargin = null;
    FCPObj.End_Date__c = null;

    return null;
    }
   

    public Pagereference DiscountMassUpdateBtnClick(){
        //FCP Dates validation
        List<string> errorproductcodeList = new LIst<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true && fcpwrapperObj.flexiblecontractprice.End_Date__c < fcpwrapperObj.flexiblecontractprice.Start_Date__c ){            
                errorproductcodeList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeList);
            }
        }
        if(errorproductcodeList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'End date should be greater than Start date.Product Codes:'+FormatProductCodeString(errorproductcodeList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
        //validate: Start Date & End Date difference should not be greater than 365 days
        List<string> errorproductcodeforenddateList = new List<string>();
        for(FCPWrapper fcpwrapperObj : FCPWrapperList){
            if(fcpwrapperObj.isselected == true &&  fcpwrapperObj.flexiblecontractprice.Start_Date__c.daysBetween(fcpwrapperObj.flexiblecontractprice.End_Date__c)> 365){            
                errorproductcodeforenddateList.add(fcpwrapperObj.flexiblecontractprice.Product_code__c);
                FormatProductCodeString(errorproductcodeforenddateList);
            }
        }
        if(errorproductcodeforenddateList.size()>0){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date & End Date difference should not be greater than one year.Product Codes:'+FormatProductCodeString(errorproductcodeforenddateList));
            ApexPages.addmessage(errormsg);
            return null;
        }
        
    updateFCPList.clear();
    
    for(FCPWrapper fcpwrapperObj : FCPWrapperList){
        if(fcpwrapperObj.isselected == true){            
            if(selecteddiscountparameter == 'QBook'){
                fcpwrapperObj.flexiblecontractprice.sales_price__c = (fcpwrapperObj.flexiblecontractprice.Q_Book__c - (fcpwrapperObj.flexiblecontractprice.Q_Book__c*(Double.valueOf(discountpercentage)))/100);        
                if(fcpwrapperObj.flexiblecontractprice.sales_price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c) fcpwrapperObj.flexiblecontractprice.sales_price__c = fcpwrapperObj.flexiblecontractprice.Min_Price__c;
                if(fcpwrapperObj.flexiblecontractprice.sales_price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c) fcpwrapperObj.flexiblecontractprice.sales_price__c = fcpwrapperObj.flexiblecontractprice.Max_Price__c;
               
                fcpwrapperObj.flexiblecontractprice.margin2__c = ((fcpwrapperObj.flexiblecontractprice.sales_price__c-fcpwrapperObj.flexiblecontractprice.cost_price__c)/fcpwrapperObj.flexiblecontractprice.sales_price__c)*100;
                
                updateFCPList.add(fcpwrapperObj.flexiblecontractprice);
            }
            if(selecteddiscountparameter == 'SBook'){
                fcpwrapperObj.flexiblecontractprice.sales_price__c = (fcpwrapperObj.flexiblecontractprice.S_Book__c - (fcpwrapperObj.flexiblecontractprice.S_Book__c*(Double.valueOf(discountpercentage)))/100);        
                if(fcpwrapperObj.flexiblecontractprice.sales_price__c < fcpwrapperObj.flexiblecontractprice.Min_Price__c) fcpwrapperObj.flexiblecontractprice.sales_price__c = fcpwrapperObj.flexiblecontractprice.Min_Price__c;
                if(fcpwrapperObj.flexiblecontractprice.sales_price__c > fcpwrapperObj.flexiblecontractprice.Max_Price__c) fcpwrapperObj.flexiblecontractprice.sales_price__c = fcpwrapperObj.flexiblecontractprice.Max_Price__c;
               
                fcpwrapperObj.flexiblecontractprice.margin2__c = ((fcpwrapperObj.flexiblecontractprice.sales_price__c-fcpwrapperObj.flexiblecontractprice.cost_price__c)/fcpwrapperObj.flexiblecontractprice.sales_price__c)*100;
                
                updateFCPList.add(fcpwrapperObj.flexiblecontractprice);    
            }
        }
    } 
    update updateFCPList;            
    FCPWrapperList.clear();
    FetchFCPWrapperList();
    getFCPWrapperList();
    selectAllFCPsFlag = false;
    
    selecteddiscountparameter = null;
    discountpercentage = null;
    selectedmarginparameter = null;
    updatedmargin = null;
    FCPObj.End_Date__c = null;
        
    return null;
    }
    
//-----------------------Supporting Methods--------------------------------
    public List<FCPWrapper> FetchFCPWrapperList(){
        for(Flexible_Contract_Price__c FCPObj : [Select f.Product__c,f.Product_Category__c, f.product_code__c, Product_Name__c , f.Cost_Price__c, f.Suggested_Price__c, f.Status__c, f.Start_Date__c, f.Sales_Price__c, f.S_Book__c, f.Q_Book__c, 
                                            f.Name, f.Min_Price__c, f.Max_Price__c, f.Id, f.Margin2__c, f.G_Book__c, f.End_Date__c, f.mass_price_change__c,f.Contract__c From Flexible_Contract_Price__c f where f.Contract__c=:contractObj.Id order by f.Product_Category__c]){
                FCPWrapperList.add(new FCPWrapper(FCPObj));
                ProductIdFCPMap.put(FCPObj.Product__c,FCPObj); 
        }
    return FCPWrapperList;
    }
         
    public List<String> SeperateProductCodes(String productCodeStr){
        List<String> productcodeList = new List<String>();
        productcodeList = productCodeStr.split(',', -2);
        return productcodeList; 
    }
    
    public String FormatProductCodeString(List<string> productcodelist){
    string productcodestr ='';
        if(productcodelist.size()>0){
            for(integer count=0;count<productcodelist.size();count++){
            productcodestr = productcodestr + productcodelist[count]; 
            if(count < productcodelist.size()-1) productcodestr = productcodestr + ',';    
            }
        }
    return productcodestr; 
    }
    
    public class ProductWrapper{
    public Product2 product{get;set;}
    public Boolean isselected{get;set;}
        public ProductWrapper(Product2 p){
            product = p;
            isselected = false;
        }
    }
        
    public class FCPWrapper{
    public Flexible_Contract_Price__c flexiblecontractprice{get;set;}
    public Boolean isselected{get;set;}
        public FCPWrapper(Flexible_Contract_Price__c fcp){
            flexiblecontractprice = fcp;
            isselected = false;
        }
    }
//---------------------------------------Sorting Methods----------------------------------------------
}