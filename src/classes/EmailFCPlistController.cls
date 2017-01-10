public class EmailFCPlistController{

private String sContractId = ApexPages.CurrentPage().getParameters().get('p3_lkid'); 

List<Flexible_Contract_Price__c> lstFlexible_Contract_Price = new lIST<Flexible_Contract_Price__c>();
public EmailFCPlistController(){
lstFlexible_Contract_Price = [Select Name, CurrencyIsoCode, Sales_Price__c, Product__r.Name, Product__r.Description from Flexible_Contract_Price__c where Contract__c = :sContractId and Status__c = :'Activated']; 
}
public List<Flexible_Contract_Price__c> getFlexible_Contract_Price() {
return lstFlexible_Contract_Price;}

}