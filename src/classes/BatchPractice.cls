global class BatchPractice implements Database.Batchable<sObject>, Database.Stateful { 
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        List<CronTrigger> cron = new List<CronTrigger>();
        cron = [SELECT PreviousFireTime, NextFireTime FROM CronTrigger]; 
//      Datetime myDate1 = Datetime.newInstance(cron[0].PreviousFireTime);
//		Datetime myDate2 = Datetime.newInstance(cron[0].NextFireTime);
   		return Database.getQueryLocator('SELECT Id, IsDeleted, AccountId, RecordTypeId, IsPrivate, Name, Description, StageName, Amount, Probability, ExpectedRevenue, TotalOpportunityQuantity, CloseDate, Type, NextStep, LeadSource, IsClosed, IsWon, ForecastCategory, ForecastCategoryName, CampaignId, HasOpportunityLineItem, Pricebook2Id, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, FiscalQuarter, FiscalYear, Fiscal, LastViewedDate, LastReferencedDate, SyncedQuoteId, ContractId, HasOpenActivity, HasOverdueTask, DeliveryInstallationStatus__c, TrackingNumber__c, OrderNumber__c, CurrentGenerators__c, MainCompetitors__c, Order_Generated__c, Contract_Generated__c, Acc_Rating__c from Opportunity WHERE CreatedDate > myDate1 AND CreatedDate < myDate2');
    }
    global void execute(Database.BatchableContext bc, List<Opportunity> scope){
        // process each batch of records
        List<Opportunity> opptys = new List<Opportunity>();
        for(Opportunity oppty : scope){   
        	opptys.add(oppty);
        }
        //turn each record info into JSON type data.
        OpportunityContainer container = new OpportunityContainer();
        container.opptys = opptys;
        String jsonText = JSON.serialize(container, Null);
//        update opptys;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}