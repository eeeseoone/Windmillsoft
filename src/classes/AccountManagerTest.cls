@IsTest
private class AccountManagerTest {
	// Helper method
    @testSetup static void createTestRecord() {
        // Create test record
        
    }    
	
    @isTest static void testGetAccount(){
		Account accountTest = new Account(Name = 'test account');
        insert accountTest;
        
        Contact con1 = new Contact();
    	con1.LastName = 'hello';
    	con1.AccountId = accountTest.Id;
    	insert con1;
    	
    	Contact con2 = new Contact();
    	con2.LastName = 'kitty';
		con2.AccountId = accountTest.Id;
		insert con2; 
        
        
    	RestRequest request = new RestRequest();
    	request.requestUri = 
    		'https://speaker-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
    		+ accountTest.Id+'/contacts';
    	request.httpMethod = 'Get';
    	RestContext.request = request;

    	Account thisAccount = AccountManager.getAccount();
    	System.assert(thisAccount != null);
    	System.assertEquals('test account', thisAccount.Name);
    }
    
      
}