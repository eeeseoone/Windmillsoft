@isTest
private class DailyLeadProcessorTest {
public static String CRON_EXP = '0 0 0 2 6 ? 2022';
/*	
	@testSetup
	static void setup(){
		List<Lead> leads = new List<Lead>();
		for(integer i=0; i<220; i++){
			Lead l = new Lead(leadSource='', lastName = 'test' + i, company='windmill');
			leads.add(l);
		}
		insert leads;
	}
*/
	static testmethod void testScheduledJob(){
		
		List<Lead> leads = new List<Lead>();
		for(integer i=0; i<200; i++){
			Lead l = new Lead(leadSource='', lastName = 'test' + i, company='windmill');
			leads.add(l);
		}
		insert leads;
	
		Test.startTest();
		String jobId = System.schedule('Update Leadsource to DreamForce', 
										CRON_EXP, 
										new DailyLeadProcessor());
		Test.stopTest();
	}   
}