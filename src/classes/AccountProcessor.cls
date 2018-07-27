global class AccountProcessor {
    
    @future //-->identifies methods that run asynchronously (in its own thread)
    		//must be static and can only return a void type
    		//parameters must be primitive types
    public static void countContacts(List<Id> AccIds){ //accepts a List of Account IDs
/*
For each Account ID passed to the method, 
count the number of Contact records associated to it 
and update the 'Number_of_Contacts__c' field with this value.
*/
		List<Account> accounts = [SELECT Id FROM Account WHERE Id IN :AccIds];

    }
}