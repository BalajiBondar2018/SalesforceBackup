public class StaticVarController {
 public Static Integer staticvar{get;set;}
    public PageReference CancelClick() {
        return null;
    }


    public PageReference UpdateClick() {
        return null;
    }



    public PageReference OnLoad() {
      staticvar = 2;
        return null;
    }



}