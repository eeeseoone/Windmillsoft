@RestResource(urlMapping='/Demo/*')
global class DemoController {
    
    //GET request
    @HttpGet
    global static List<Demo__c> getRecords(){
    	List<Demo__c> demoRecords = [SELECT Id, Name from Demo__c];
    	return demoRecords;
    }
    
    //POST request to create the Demo record into System
    @HttpPost
    global static Demo__c createNewRecords(String Name){
    	Demo__c demo = new Demo__c();
    	demo.Name = Name;
    	insert demo;
    	String returnMessage = 'You have successfully created a Demo record into Salesforce- '+'Record Id of the record is- '+demo.id;
    	return[SELECT Id, Name, Owner.Name From Demo__c Where Id=: demo.id];
    }
    
    //DELETE to delete the given Demo
    @HttpDelete
    global static String deleteDemoRecordById(){
    	String Id = RestContext.request.params.get('Id');
    	List<Demo__c> w = [SELECT ID from Demo__c Where Id=:Id];
    	delete w;
    	return 'Deleted Demo';
    }
    
    //UPDATE the Demo Record
    @HttpPut
    global static String updateDemo(String Id, String NewName){
    	Demo__c demo = [SELECT ID, Name from Demo__c Where Id=:Id];
    	demo.Name = NewName;
    	update demo;
    	return 'Updated Demo';
    }
}