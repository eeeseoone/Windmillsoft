// if an opportunity is inserted or updated with a stage of 'Closed Won', 
//it will have a task created with the subject 'Follow Up Test Task'.
//To associate the task with the opportunity, fill the 'WhatId' field with the opportunity ID.
trigger ClosedOpportunityTrigger on Account (after insert, after update) {

	List<Task> tasklist = new List<Task>();
	List<Opportunity> opplist = new List<Opportunity>();

	for(Account a : Trigger.New){
			opplist=[SELECT Id, Stagename 
			FROM Opportunity
    		WHERE AccountId =:a.Id]; 



	}
}
/*
[SELECT Id, Stage 
FROM Opportunity 
WHERE ID IN : Trigger.NEW 
AND Stage IN 'Closed Won']

	for(Account a : Trigger.New){
			opplist=[SELECT Id, Stage 
			FROM Opportunity
    		WHERE AccountId =:a.Id]; 
	}
*/