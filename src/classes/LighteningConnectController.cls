public class LighteningConnectController {

    public List<OfficeDepot__Categories__x> getCategoriesList(){
        List<OfficeDepot__Categories__x> CategoriesList = [SELECT OfficeDepot__CategoryID__c,OfficeDepot__CategoryName__c,OfficeDepot__Description__c FROM OfficeDepot__Categories__x LIMIT 5];
        return CategoriesList ;
    }
    
    
     public List<OfficeDepot__Orders__x> getOrdersList(){
        List<OfficeDepot__Orders__x> OrdersList = [SELECT OfficeDepot__CustomerID__c,OfficeDepot__EmployeeID__c,OfficeDepot__Freight__c,OfficeDepot__OrderDate__c,OfficeDepot__OrderID__c,OfficeDepot__RequiredDate__c,OfficeDepot__ShipAddress__c,OfficeDepot__ShipCity__c,OfficeDepot__ShipCountry__c,OfficeDepot__ShipName__c,OfficeDepot__ShippedDate__c,OfficeDepot__ShipPostalCode__c,OfficeDepot__ShipRegion__c,OfficeDepot__ShipVia__c FROM OfficeDepot__Orders__x LIMIT 5];
        return OrdersList ;
    }

}