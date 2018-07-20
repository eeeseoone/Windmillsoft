@isTest(seeAllData=false)
private class JoinContactToCaseTest {

	public static List<Contact> contactsList;
	public static List<Case> casesList;
	public static String email1;
   
	static void init(){
   	contactsList = new List<Contact>();
   	casesList = new List<Case>();
  	 
   	email1 = 'toto@toto.com';
  	 
   	casesList.add(new Case(
       		SuppliedEMail = email1
   	));
	}

	/** Test with an existing contact **/
	static testMethod void testWithExistingContact() {
   	init();
   	Test.startTest();
  	 
   	contactsList.add(new Contact(
       	Email = email1,
       	LastName = email1
   	));
   	insert contactsList;
  	 
   	insert casesList;
  	 
   	// Getting the case to verify that the ‘ContactId’ field is not null
   	casesList = [
       	SELECT Id, ContactId
       	FROM Case
       	WHERE Id = :casesList[0].Id
   	];
  	 
   	// Verification
   	System.assertEquals(casesList[0].ContactId, contactsList[0].Id);
  	 
   	Test.stopTest();
	}
   
	/** Test with a non-existent contact **/
	static testMethod void testWithDoesntExistingContact() {
   	init();
   	Test.startTest();
  	 
   	insert casesList;
  	 
   	// Getting the case to verify the ‘ContactId’ field is not null
   	casesList = [
       	SELECT Id, ContactId
       	FROM Case
       	WHERE Id = :casesList[0].Id
   	];
  	 
   	// Getting the contact created with the Apex trigger
   	contactsList = [
       	SELECT Id, Email
       	FROM Contact
       	WHERE Email = :email1
   	];
  	 
   	// Verification
   	System.assertEquals(casesList[0].ContactId, contactsList[0].Id);
  	 
   	Test.stopTest();
	}
}