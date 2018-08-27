public class RandomAccountContactFactory {
	    
    public static List<Account> generateRandomAccounts(Integer numAccounts){
    	List<Account> accounts = new List<Account>();
    	
    	for(integer i = 0; i<numAccounts; i++){
    		Account a = new Account();
    		a.Name = 'Test' + i;
    		accounts.add(a);
    	}
    	return accounts;
    }
    
    public static List<Contact> generateRandomContacts(Integer numContacts, String lastName, Id accId){
    	List<Contact> contacts = new List<Contact>();
    	
    	for(integer i = 0; i<numContacts; i++){
    		Contact c = new Contact();
    		c.FirstName = 'Trail' + i;
    		c.LastName = lastName + i;
    		c.AccountId = accId;
    		contacts.add(c);
    	}
    	return contacts;
    }
}