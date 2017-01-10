trigger IntiateAccountOwnerChangeRequest on ADR_Request__c (After Insert) {
    
    for(Integer i = 0; i < Trigger.new.size(); i++){
        try{
            if(Trigger.new[i].Mass_Reassignment__c !=TRUE){
                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                req.setComments('Submitted for approval. Please approve.');
                req.setObjectId(Trigger.new[i].Id);
                // submit the approval request for processing
                Approval.ProcessResult result = Approval.process(req);
                // display if the reqeust was successful
                //System.debug('Submitted for approval successfully: '+result.isSuccess());
            }
        }
        catch(Exception ex){
            for (Integer excount = 0; excount  < ex.getNumDml(); excount ++) {
            Trigger.new[i].addError(ex.getDmlMessage(excount));
            }
        }
    }
}