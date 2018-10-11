global class BatchPractice implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {  
	
	global String test = '';
 	global static Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

    global Database.QueryLocator start(Database.BatchableContext bc) {   
        // collect the batches of records or objects to be passed to execute

		System.debug('You have made ' + Limits.getEmailInvocations() + ' email calls out of ' + Limits.getLimitEmailInvocations() + ' allowed');
		
			
  		Datetime now =  Datetime.now();  //not quite sure if this is Korea time standard.
  		Integer offset = UserInfo.getTimezone().getOffset(now);
		Datetime local = now.addSeconds(offset/1000);
  		System.debug('this is local time for now: ' +now);  		
  		//now minus 7 days
  		Datetime weekAgo = now.addDays(-7);
 		System.debug('this is weekAgo: ' + weekAgo);
 		List<EmailTemplate> etList = [SELECT Id, Body, Subject from EmailTemplate
 										WHERE DeveloperName = 'Batch_Notice'];
 		System.debug('this is list size in start method: '+ etList.size());
 		etList[0].Body = 'Batch Job 시작 시간: ' + local +'\n' + '리턴받은 리스트의 사이즈: ' + etList.size();
 		etList[0].Subject = local +'에 Batch Job 이 시작되었습니다.';
 		update(etList);
 		
 		email.setTemplateId(etList[0].Id);
 		email.setSaveAsActivity(false);
 		email.setTargetObjectId('0057F000003c8QUQAY');
 //		email.setToAddresses(new list<String>{'leefrances@naver.com'});	
 		
 		Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
 		System.debug('this is resultMail: ' + resultMail);
 		test = 'run#1';
 		
   		return Database.getQueryLocator('SELECT Id FROM Opportunity LIMIT 1'); //WHERE CreatedDate > ' +weekAgo+''
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> scope){
        // process each batch of records 
        System.debug('we are in execute');
        String subject = '';
        String report = '';  
        boolean hasError = false; 
        Integer errorCount = 0;
        String msg = ''; 
        String endpoint ='https://onelivechat-developer-edition.ap5.force.com';
        List<Opportunity> opptys = new List<Opportunity>();
        
        //###potential error
        try{
        	for(Opportunity oppty : scope){   
        		System.debug('this is oppty in scope: ' + oppty);
        		opptys.add(oppty); 
        	}}catch(Exception e){ //캐치할게 없으면 여기 아예 안들어오잖아..-.-
        			System.debug('this is Exception from For Loop: ' +  e);
        			msg+='for루프 중에 문제생김: ' +e.getMessage();
        			errorCount++;
        	  }finally{
					msg+='for루프 이상 없음/ ';
        	  }
        	
        //turn each record info into JSON type data.
        OpportunityContainer container = new OpportunityContainer();
        //###potential error
        try{
        	container.opptys = opptys;
        }catch(Exception e){
        		System.debug('this is Exception from container.opptys: '+ e);
        		msg+='Container 클래스 타면서 문제생김: ' + e.getMessage();  
        		errorCount++;      
        }finally{
        		msg+='Container 클래스 타기 이상없음! '; System.debug('this is report before json: '+report);
        		System.debug('container.opptys: ' + container.opptys);
        }
        String jsonTxt = System.JSON.serialize(container);
       	System.debug('this is jsonTxt: '+jsonTxt);
		
		       	       	
		//http request 보내기까지 마치고, 관리자에게 email alert 보내기 
        //###potential error -->while sending HttpReq
        try{
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		Http http = new Http();
		
		Blob headerValue = Blob.valueOf('leefrances' + ':' + 'FrancesLee5353');
		String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
		req.setHeader('Authorization', authorizationHeader);
		req.setHeader('Content-Type', 'application/json');
		req.setEndpoint(endpoint);
		req.setMethod('POST');
		req.setBody(jsonTxt);
		req.setCompressed(true);
			
		res = http.send(req);
		if(res.getStatusCode() == 200){
			System.debug('>>>>>>>>HTTP Post Success!');
//			String sJson = res.getBody();
//			System.debug('this is response: ' + res.getBody());
		}
        }catch(Exception e){
        	System.debug('Error: ' + e.getMessage() + 'LN: '+e.getLineNumber() );
        	msg+= 'HTTP Request에서 문제생김: '+e.getMessage();
        }

        List<EmailTemplate> tmp = [SELECT Subject, Body from EmailTemplate
        							WHERE DeveloperName = 'Batch_Result_Notice'];
        
        if(errorCount>0){
        	hasError = true;
        	subject = 'Batch Job 도중 에러발생';
        	report = 'error생성여부: ' + hasError + '\n' + 'error메시지: ' + msg + '\n' + 'JSON결과: ' + jsonTxt;
        }else{
        	hasError = false;
        	subject = 'Batch Job 성공적으로 완료';
        	report = 'error생성여부: ' + hasError + '\n' + '메시지: ' + msg + '\n' + 'JSON결과: ' + jsonTxt;
        }
		
		tmp[0].Body = report;
		tmp[0].Subject = subject;
        update tmp; 
        
       	/**********this is where we send Email**********/
	       	List<EmailTemplate> etList = [SELECT Id, Body, Subject from EmailTemplate
	 										WHERE DeveloperName = 'Batch_Result_Notice'];
	 		System.debug('this is list size in start method: '+ etList.size());
	 		email.setTemplateId(etList[0].Id);
	 		email.setSaveAsActivity(false);
	 		email.setTargetObjectId('0057F000003c8QUQAY');
//	 		email.setToAddresses(new list<String>{'leefrances@naver.com'});	
	 		
//	 		Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
//	 		System.debug('this is resultMail: ' + resultMail);
       	/**********this is where we send Email**********/
		
        test = 'run#2';
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('we are in finish');
        test = 'run#3';
    }    
}