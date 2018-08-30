global class DailyLeadProcessor implements Schedulable {
    
    global void execute(SchedulableContext  ctx){
    	List<Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null limit 200];
		List<Lead> updateLeads = new List<Lead>();

    	for(Lead lead: leads){
    		lead.leadSource = 'Dreamforce';
    		updateLeads.add(lead);
    	}
    	update updateLeads;
    }
}