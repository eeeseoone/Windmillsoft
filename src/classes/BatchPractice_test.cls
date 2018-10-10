global class BatchPractice_test implements Database.Batchable<sObject>, Database.Stateful { 
    global Database.QueryLocator start(Database.BatchableContext bc) {
    	
    	//Schedule Batch Programmatically Practice
    	BS2 bs = new BS2();
    	//8:30am every 1st day of the month-->but I don't this you have to use Cron Expression
    	String cronExp = '0 30 8 1 * * *'; 
    	//this is where you get your jobId
    	String jobId = System.schedule('This is Windmillsoft Weekly Batch Job', cronExp, bs); 
    	System.debug('this is schedule job id: ' + jobId);
    	
        // collect the batches of records or objects to be passed to execute
        //CronTrigger 테이블의 경우, apex스케줄이 안잡혀있지 않으면 ROW가 없다
        List<CronTrigger> cron = new List<CronTrigger>();
        cron = [SELECT NextFireTime FROM CronTrigger];
  		System.debug('this is previousfiretime: ' + cron[0].NextFireTime );      
  		Datetime nft = cron[0].NextFireTime ; 
  		Datetime dt =  Datetime.newInstance(2018,10,10,0,0,0);
  		System.debug('this is NextFireTime: '+nft + 'this is dt:' +dt);
	    Datetime myDate1 = Datetime.valueOf(cron[0].NextFireTime);

   		return Database.getQueryLocator('SELECT Id, IsDeleted, AccountId, RecordTypeId, IsPrivate, Name, Description, StageName, Amount, Probability, ExpectedRevenue, TotalOpportunityQuantity, CloseDate, Type, NextStep, LeadSource, IsClosed, IsWon, ForecastCategory, ForecastCategoryName, CampaignId, HasOpportunityLineItem, Pricebook2Id, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, FiscalQuarter, FiscalYear, Fiscal, LastViewedDate, LastReferencedDate, SyncedQuoteId, ContractId, HasOpenActivity, HasOverdueTask, DeliveryInstallationStatus__c, TrackingNumber__c, OrderNumber__c, CurrentGenerators__c, MainCompetitors__c, Order_Generated__c, Contract_Generated__c, Acc_Rating__c from Opportunity WHERE CreatedDate < '+ nft +' AND CreatedDate >' + dt + '');
    } 
    global void execute(Database.BatchableContext bc, List<Opportunity> scope){
        // process each batch of records 
        List<Opportunity> opptys = new List<Opportunity>();
        for(Opportunity oppty : scope){   
        	System.debug('this is oppty in scope: ' + oppty);
        	opptys.add(oppty);
        }
        //turn each record info into JSON type data.
        OpportunityContainer container = new OpportunityContainer();
        container.opptys = opptys;
        String jsonText = JSON.serialize(container, Null);
        System.debug('this is jsonText: ' + jsonText);
//        update opptys;
    }     
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('bye for now');
    }    
}