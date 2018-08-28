//In the test class, insert 200 Lead records, 
//execute the 'LeadProcessor' Batch class 
//and test that all Lead records were updated correctly.

@isTest
private class LeadProcessTest {
	
	@testSetup
	static void setup(){
		List<Lead> leads = new List<Lead>();
		for(Integer i=0;i<200;i++){
			leads.add(new Lead(leadSource='hi', lastName ='test', company='windmill'));
		}
		insert leads;
	}
	
    
	static testmethod void test(){
		Test.startTest();
			LeadProcessor lp = new LeadProcessor();
			Id batchId = Database.executeBatch(lp);
		Test.stopTest();
		
		System.assertEquals(200, [SELECT count() from lead where leadSource = 'Dreamforce']);
	}
}