public class StackXml{
    public List<SelectOption> allOptions {get;private set;}    // this will hold serial numbers for use in VF page.
    // if you wouldn't plan to use VF with checkboxes, simple List<String> would be enough

    public List<String> selectedOptions {get;set;}

    public StackXml(){
        allOptions = new List<SelectOption>();
        selectedOptions = new List<String>();

        String xmlString = '<serials><serialNumber>ver123</serialNumber><serialNumber>ver456 </serialNumber>' +
            '<intrusion>something to prove it will be skipped</intrusion>' +
            '<serialNumber>abc007</serialNumber></serials>';

        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);

        Dom.XMLNode rootElement = doc.getRootElement();
        for(Dom.XmlNode node : rootElement.getChildElements()){
            if(node.getName().trim() == 'serialNumber') {
                String text = node.getText().trim();
                allOptions.add(new SelectOption(text, text));
            }
        }
    }

    public void assign(){}
}