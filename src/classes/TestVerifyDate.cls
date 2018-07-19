@isTest
public class TestVerifyDate {

    @isTest static void testCheckDates_a(){
		system.debug('testA');

		Date a = Date.valueOf('2018-05-17');
		Date b = Date.valueOf('2018-05-19');
		
		Date testDate = VerifyDate.CheckDates(a,b);  //-->either returned date 2 or (date 1 + 30
		System.assertEquals(b, testDate);
    }
    
	@isTest static void testCheckDates_b(){
		system.debug('testA');

		Date a = Date.valueOf('2018-05-1');
		Date b = Date.valueOf('2018-06-19');
		
		Date testDate = VerifyDate.CheckDates(a,b);  //-->either returned date 2 or (date 1 + 30)
		System.assertEquals(Date.valueOf('2018-05-31'), VerifyDate.SetEndOfMonthDate(a));
		system.debug('VerifyDate.SetEndOfMonthDate(a): '+VerifyDate.SetEndOfMonthDate(a));
    }
    
    @isTest static void testDateWithin30Days(){
    	system.debug('testB');

		Date a = Date.valueOf('2010-05-1');
		Date b = Date.valueOf('2010-05-30');
		Boolean bln = VerifyDate.DateWithin30Days(a,b);  
    	
    	System.assertEquals(true, bln);    	
    }
    
    @isTest static void testSetEndOfMonthDate(){
    	system.debug('testC');
 
 		Date a = Date.valueOf('2018-07-19');
		Date lastDate = VerifyDate.SetEndOfMonthDate(a);
		
		System.assertEquals(Date.valueOf('2018-07-31'), lastDate);      	
    }    
}