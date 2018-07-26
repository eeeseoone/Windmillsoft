//If an account record has related opportunities, 
//the AccountDeletion trigger prevents the record’s deletion.

trigger AccountDeletion on Account(before delete){
	
	//Prevent the deletion of accounts if they have related opportunities.
	for(Account a: [SELECT Id FROM Account
					WHERE Id IN (SELECT AccountId FROM Opportunity) AND
					Id IN:Trigger.old]){
			Trigger.oldMap.get(a.Id).addError( 	//.oldMap -> A map of IDs to the old versions of the sObject records.
												//This map is only available in update and delete triggers.
					'Cannot delete account with related opportnities');
	}
}