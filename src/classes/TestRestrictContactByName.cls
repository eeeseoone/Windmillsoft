//The unit tests must cover scenarios 
//for all lines of code included in the Apex trigger, 
//resulting in 100% code coverage.

@isTest
public class TestRestrictContactByName {

	@isTest static void testWithBannedName(){
		
		Contact con= new Contact(LastName = 'INVALIDNAME');
		
			test.startTest();
				Database.SaveResult result = Database.insert(con, false);
			test.stopTest();
		
		system.debug('result: ' + result);
			
		system.assert(!result.isSuccess());
		system.assert(result.getErrors().size() > 0);
		system.assertEquals('The Last Name "'+ con.LastName +'" is not allowed for DML',
                             result.getErrors()[0].getMessage());
		system.debug('errormessage: ' +   result.getErrors()[0].getMessage());
	}
}