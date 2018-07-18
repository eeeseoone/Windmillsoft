public with sharing class ContactSearch {
    
    public static Contact[] searchForContacts(String a, String b){
    	
    	Contact[] findContacts = [SELECT ID, Name 
							    	from Contact 
							    	Where LastName =: a and MailingPostalCode =: b];
							    	
		return findContacts;
    }
}