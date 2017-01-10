public class AuthSubTokenCompContrller {
  // should only be used after we have a token
    public string convertTokenToSession { get { 
        string tt = ApexPages.currentPage().getParameters().get('token');
        system.assert(tt!=null,' missing token paramater');
        ApexPages.currentPage().getParameters().remove('token');
        
        string st = AuthSubUtil.exchangeForSessionToken( tt ) ;
        ApexPages.currentPage().getParameters().put('sesstoken',st);
        system.debug( ApexPages.currentPage().getUrl()); 
        return ApexPages.currentPage().getUrl(); 
    } }
}