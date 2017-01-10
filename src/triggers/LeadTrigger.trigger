trigger LeadTrigger on Lead(after delete, after insert, after update, before delete, before insert, before update){
    LeadTriggerFactory.createHandler(Lead.sObjectType);
}