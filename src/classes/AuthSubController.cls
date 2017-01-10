public class AuthSubController {
    
    public pagereference exchangeRequestToken() {
        if ( ApexPages.currentPage().getParameters().get('token') != null) { 
            string sessToken = 
             AuthSubUtil.exchangeForSessionToken( 
                ApexPages.currentPage().getParameters().get('token'));
            // store the token 
            // this assumes a you store tokens in a custom object
            Account session = new Account(id=
                ApexPages.currentPage().getParameters().get('id'),
                 Name = sessToken );
            
            update session; 
        }
        return null;
    }
    public boolean getRequestToken() {
        return (ApexPages.currentPage().getParameters().get('token') == null
        && ApexPages.currentPage().getParameters().get('id') != null);
    }
}