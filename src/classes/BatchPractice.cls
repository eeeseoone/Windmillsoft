global class BatchPractice implements Database.Batchable<sObject> , Database.Stateful {  
	
	global String test = '';
	
    global Database.QueryLocator start(Database.BatchableContext bc) {   
        // collect the batches of records or objects to be passed to execute
        //CronTrigger 테이블의 경우, apex스케줄이 안잡혀있지 않으면 ROW가 없다
        //당연히 스케줄을 잡아야 이 뱃치가 실행되기때문에 empty row같은 문제는 걱정하지 않아도 되지만
        //해당 뱃치잡과 연결되는 schedule job id 를 구하는것이 문제.
        //그리고 첫 scheduled job에서는 previous fire time필드값이 비어있다는 점도.
        List<CronTrigger> cron = new List<CronTrigger>();
        cron = [SELECT NextFireTime FROM CronTrigger]; //have to know the schedulejobid !!
//	    Datetime preTime = Datetime.valueOf(cron[0].PreviousFireTime);
		Datetime nextTime = Datetime.valueOf(cron[0].NextFireTime); 
  		System.debug('this is next fire time: ' + cron[0].NextFireTime );      
  		Datetime todayTime =  Datetime.newInstance(2018,10,10,0,0,0);  //not quite sure if this is Korea time standard.
  		System.debug('this is NextFireTime: '+nextTime + 'this is todayTime:' +todayTime);
 		
 		test = 'run#1';
 		
   		return Database.getQueryLocator('SELECT Id, IsDeleted, AccountId, RecordTypeId, IsPrivate, Name, Description, StageName, Amount, Probability, ExpectedRevenue, TotalOpportunityQuantity, CloseDate, Type, NextStep, LeadSource, IsClosed, IsWon, ForecastCategory, ForecastCategoryName, CampaignId, HasOpportunityLineItem, Pricebook2Id, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, FiscalQuarter, FiscalYear, Fiscal, LastViewedDate, LastReferencedDate, SyncedQuoteId, ContractId, HasOpenActivity, HasOverdueTask, DeliveryInstallationStatus__c, TrackingNumber__c, OrderNumber__c, CurrentGenerators__c, MainCompetitors__c, Order_Generated__c, Contract_Generated__c, Acc_Rating__c from Opportunity WHERE CreatedDate < '+ nextTime +' AND CreatedDate >' + todayTime + '');
    } 
    global void execute(Database.BatchableContext bc, List<Opportunity> scope){
        // process each batch of records 
        List<Opportunity> opptys = new List<Opportunity>();
        for(Opportunity oppty : scope){   
        	System.debug('this is oppty in scope: ' + oppty);
        	opptys.add(oppty);
        }
        //turn each record info into  JSON type data.
        OpportunityContainer container = new OpportunityContainer();
        container.opptys = opptys;
        String jsonText = JSON.serialize(container, Null);
        System.debug('this is jsonText: ' + jsonText);
        test = 'run#2';
//        update opptys;
    }     
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('bye for now');
        test = 'run#1';
    }    
}