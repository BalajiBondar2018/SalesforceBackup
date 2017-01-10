trigger OpportunityTrigger on Opportunity (after insert, after update, after delete) {
    if(Trigger.isAfter && Trigger.isInsert) {
        OpportunityTriggerHandler.handleAfterInsert(Trigger.new);
    } 
    else if(Trigger.isAfter && Trigger.isDelete) {
        OpportunityTriggerHandler.handleAfterDelete(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isUpdate) {
        OpportunityTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.old);
    }
}