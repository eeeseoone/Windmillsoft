@isTest
public class TestVerifyDate {

    @isTest static void ScenarioA(){
		system.debug('testDate??');

		Date a = Date.valueOf('2010-05-17');
		Date b = Date.valueOf('2010-05-19');
		Date testDate = VerifyDate.CheckDates(a,b);  
		
		System.assertEquals(b, testDate);
		system.debug('testDate' + testDate);
    }
}