global class BatchPractice implements Database.Batchable<sObject>, Database.Stateful {  
	
	global String test = ''; 
	 
    global Database.QueryLocator start(Database.BatchableContext bc) {   
        // collect the batches of records or objects to be passed to execute
        //CronTrigger 테이블의 경우, apex스케줄이 안잡혀있지 않으면 ROW가 없다
        //당연히 스케줄을 잡아야 이 뱃치가 실행되기때문에 empty row같은 문제는 걱정하지 않아도 되지만
        //해당 뱃치잡과 연결되는 schedule job id 를 구하는것이 문제.
        //그리고 첫 scheduled job에서는 previous fire time필드값이 비어있다는 점도.

  		Datetime now =  Datetime.now();  //not quite sure if this is Korea time standard.
  		Integer offset = UserInfo.getTimezone().getOffset(now);
		Datetime local = now.addSeconds(offset/1000);
  		
  		System.debug('this is local time for now: ' +now);
  		
  		//now minus 7 days
  		Datetime weekAgo = now.addDays(-7);
 		System.debug('this is weekAgo: ' + weekAgo);
 		
 		test = 'run#1';
 		
   		return Database.getQueryLocator('SELECT Id FROM Opportunity LIMIT 1'); //WHERE CreatedDate > ' +weekAgo+''
    } 
    global void execute(Database.BatchableContext bc, List<Opportunity> scope){
        // process each batch of records 
        System.debug('we are in execute');
        List<Opportunity> opptys = new List<Opportunity>();
        for(Opportunity oppty : scope){   
        	System.debug('this is oppty in scope: ' + oppty);
        	opptys.add(oppty); 
        }
        //turn each record info into  JSON type data.
        OpportunityContainer container = new OpportunityContainer();
        if(!opptys.isEmpty()){
        	container.opptys = opptys;
        }
        System.debug('container.opptys: ' +container.opptys);
        String jsonTxt = System.JSON.serialize(container);
       	System.debug('this is jsonTxt: '+jsonTxt);
       	
/*      How do we deserialize JSON into List<sObject>
		public static Object deserialized(String jsonString, System.Tpe apexType)
*/


        
//        String jsonText = JSON.serialize(opptys);
//        System.debug('this is jsonText: ' + jsonText); 
//        test = 'run#2';
//        update opptys;
    }     
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('we are in finish');
        test = 'run#1';
    }    
}