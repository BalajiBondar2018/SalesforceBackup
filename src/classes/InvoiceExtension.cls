public class InvoiceExtension {
public Case caseObj = new Case();

public Case getcaseObj(){
caseObj =[select Id, CaseNumber from Case where Id='50090000000ljVM'];
return caseObj;
}

    public InvoiceExtension(ApexPages.StandardController controller) {

    }

}