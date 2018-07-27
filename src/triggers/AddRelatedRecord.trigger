//This trigger adds a related opportunity for each new or updated account 
//if no opportunity is already associated with the account.

trigger AddRelatedRecord on Account (after insert, after update) {
    List<Opportunity> oppList = new List<Opportunity>();
    
    //Get the related opportunities for the accounts in this trigger
    Map<Id, Account> acctsWithOpps = new Map<Id,Account>( //
    	 [SELECT Id,(SELECT Id FROM Opportunities) FROM Account Where Id IN:Trigger.New
    	]);
    //Add an opportunity for each account if it doesn't already have one
    //Iterate through each account.
    for(Account a : Trigger.New){ //새로 추가되거나 업데이트 된 Account객체 수 만큼 반복
    	System.debug('acctsWithOpps.get(a.Id).Opportunities.size()=' + acctsWithOpps.get(a.Id).Opportunities.size());
    	
    	//Check if the account already has a related opportunity
    	if(acctsWithOpps.get(a.Id).Opportunities.size()==0){
    		//If it doesn't, add a default opportunity
    		oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
    													StageName = 'Prospecting',
    													CloseDate = System.today().addMonths(1),
    													AccountId=a.Id));
    	}	 
    }
	if (oppList.size() > 0){
		insert oppList;
	}
}