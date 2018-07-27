trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

	List<Task> tasklist = new List<Task>();
	List<Opportunity> opplist = new List<Opportunity>();
	Opportunity opp = new Opportunity();
	
	for(Opportunity o :
		//why didn't you use o...STUPID!
		[SELECT Id, Stagename 
			FROM Opportunity
			WHERE Id IN:Trigger.New AND
			Stagename = 'closed won']){
				
				opplist.add(o);
			}
	 
	
	for(integer i = 0; i<opplist.size(); i++){
		tasklist.add(new Task(subject='Follow Up Test Task',
									WhatId = opplist[i].id));
	}
	for(integer j = 0; j<tasklist.size(); j++){
		system.debug('tasklist[j]: ' + tasklist[j]);
	}
	if(tasklist.size()>0){
		insert tasklist;
	}
}