public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(integer numContacts, string nameContact){ //The first parameter controls the number of contacts being generated, the second is the last name of the contacts generated.
    //The 'generateRandomContacts' method must be capable of 
    //consistently generating contacts with unique first names. 
    //(i.e. 'Test 1','Test 2').
    
    //The 'generateRandomContacts' method should not insert the contact records into the database.
    
    	List<Contact> contactList = new List<Contact>();
    	
    	for(integer i=0; i<numContacts; i++){
            Contact a = new Contact(FirstName= nameContact + i);
            contactList.add(a);
    	}
    	return contactList;
    }
}