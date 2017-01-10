Public class MetadataServiceHelper{

    // This is CustomObjectWrapper Wrapper/container class.
    public class CustomObjectWrapper {
    public String customobjectfullName {get; set;}
    public String customobjectlabel {get; set;}
    public String customobjectpluralLabel {get; set;}
    public String customobjectnameFieldtype{get; set;}
    public String customobjectnameFieldlabel{get; set;}
    public String customobjectsharingModel {get; set;}
    
        public CustomObjectWrapper (String customobjectfullName ,String customobjectlabel ,String customobjectpluralLabel ,String customobjectnameFieldtype,String customobjectnameFieldlabel,String customobjectsharingModel){
            this.customobjectfullName  = customobjectfullName  ;
            this.customobjectlabel = customobjectlabel ;
            this.customobjectpluralLabel = customobjectpluralLabel ;
            this.customobjectnameFieldtype= customobjectnameFieldtype;
            this.customobjectnameFieldlabel= customobjectnameFieldlabel;
            this.customobjectsharingModel = customobjectsharingModel ;
        }
    }
    
    // This is our CustomFieldWrapper Wrapper/container class.
    public class CustomFieldWrapper {
        public String customfieldFullName {get; set;}
        public String customfieldlabel {get; set;}
        public String customfieldtype {get; set;}
        public Integer customfieldlength {get; set;}
        public String customfielddefaultvalue {get; set;}
        public CustomFieldWrapper(String customfieldFullName  , String customfieldlabel  ,String customfieldtype ,Integer customfieldlength,String customfielddefaultvalue ){
            this.customfieldFullName = customfieldFullName ;
            this.customfieldlabel = customfieldlabel ;
            this.customfieldtype = customfieldtype;
            this.customfieldlength = customfieldlength; 
            this.customfielddefaultvalue = customfielddefaultvalue ;

        }
    }
    
}