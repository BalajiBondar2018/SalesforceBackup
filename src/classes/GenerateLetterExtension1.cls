public class GenerateLetterExtension1 {

    public GenerateLetterExtension1() {

    }

public string letterbodystr='';
public String getletterbodystr(){
return letterbodyStr ;
}


public void setletterbodystr(String letterbodyStr){
this.letterbodyStr = letterbodyStr ;
}





public GenerateLetterExtension1(ApexPages.StandardController controller) {
    
   
}
public pagereference onload(){

 letterbodyStr = null;
            //System.debug('@@@@@@@@@@@@@@GenerateLetterExtension1  called');
            letterbodyStr = ApexPages.currentPage().getParameters().get('letterHTMLbody');  
              System.debug(letterbodyStr);
    
return null;
}
}