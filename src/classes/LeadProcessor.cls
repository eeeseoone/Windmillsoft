global class LeadProcessor implements Database.Batchable<sObject>,Database.Stateful {

//Use a QueryLocator in the start method to 
//collect all Lead records in the org.
    global Database.QueryLocator start(Database.BatchableContext bc){ //batch의 정보
    		return Database.getQueryLocator('SELECT ID FROM LEAD');
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){    	
    		List<Lead> leads = new List<Lead>();
    		for(Lead lead : scope){ //parameter로 받 레코드 수 만큼 
    			lead.leadSource = 'Dreamforce';
    			leads.add(lead);
    		}
    		update leads;
    }
    
    global void finish(Database.BatchableContext bc){
    		AsyncApexJob job = [SELECT id FROM AsyncApexJob WHERE Id =: bc.getJobId()];
    }
}