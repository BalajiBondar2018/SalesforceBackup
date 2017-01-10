public class PasswordGenerator{
public class PasswordCharacteristics{
    public Integer MinNumberOfAlphas {
        get{
            if( MinNumberOfAlphas == null ) MinNumberOfAlphas = 1;
                return MinNumberOfAlphas;
            }
        set;
    }
 
    public Integer MinNumberOfNumeric {
        get{
            if( MinNumberOfNumeric == null ) MinNumberOfNumeric = 1;
                return MinNumberOfNumeric;
            }
        set;
    }
 
    public Integer MinNumberOfUppercase {
        get{
            if( MinNumberOfUppercase == null ) MinNumberOfUppercase = 0;
                return MinNumberOfUppercase;
            }
        set;
    }
 
    public Integer MinNumberOfLowercase {
        get{
            if( MinNumberOfLowercase == null ) MinNumberOfLowercase = 0;
                return MinNumberOfLowercase;
            }
        set;
    }
 
    public Integer MinNumberOfSpecial {
        get{
            if( MinNumberOfSpecial == null ) MinNumberOfSpecial = 0;
                return MinNumberOfSpecial;
            }
        set;
    }
 
    public Integer MinLength {
        get{
            if( MinLength == null ) MinLength = 8;
                return MinLength;
            }
        set;
    }
}

}