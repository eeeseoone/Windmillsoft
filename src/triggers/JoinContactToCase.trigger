//https://developer.salesforce.com/page/How_To_Test_Your_Apex_Triggers
trigger JoinContactToCase on Case (before insert, before update) {

	public map<String, Contact> contactsMap = new map<String, Contact>();
	public map<String, Contact> createdContacts;
	public List<String> mailsList = new List<String>();
	public List<Contact> contactToCreate = new List<Contact>();
	public List<Integer> remainderCases = new List<Integer>();
	Integer caseNumber = 0;
   
	// For each case
	for(Case myCase : Trigger.new){
  	 
   	// If the contactId field is null and the suppliedEMail field is right
   	if(myCase.ContactId == null && myCase.SuppliedEmail != null){
      	 
       	// Getting the email address
       	mailsList.add(myCase.SuppliedEmail);
   	}  	 
	}
   
	// Getting contacts linked to the email addresses
	contactsMap = getContacts(mailsList);
   
	// For each case
	for(Case myCase : Trigger.new){
  	 
   	if(myCase.ContactId == null && myCase.SuppliedEmail != null){
      	 
       	// If the contact with email address is in the map
       	if(contactsMap.containsKey(myCase.SuppliedEmail)){
           		myCase.ContactId = contactsMap.get(myCase.SuppliedEmail).Id;
       	}
       	// We add the contact in the list to create it later
       	else{
           	contactToCreate.add(new Contact(
               	Email = myCase.SuppliedEmail,
               	LastName = myCase.SuppliedEmail
           	));
          	 
           	// We specify what case we have to link to a contact
           	remainderCases.add(caseNumber);
       		}
   	}
  	 
   	caseNumber++;
	}
   
	// Creation of the contacts
	insert contactToCreate;
   
	// Getting contacts created in a map<email, contact>
	createdContacts = getContactsByMap(contactToCreate);
   
	// For each case which is not linked to a contact yet	
for(Integer theCaseNumber : remainderCases){
  	 
   	// If the contact is just created
   	if(createdContacts.containsKey(Trigger.new[theCaseNumber].SuppliedEmail)){
      	 
       	// Linking to the contact
       	Trigger.new[theCaseNumber].ContactId = createdContacts.get(Trigger.new[theCaseNumber].SuppliedEmail).Id;
   	}
	}
   
	// Return contacts linked to the email addresses given like parameters
	public map<String, Contact> getContacts(List<String> mails){
  	 
   	return getContactsByMap([
       	SELECT Id, Email
       	FROM Contact
       	WHERE Email IN :mails
   	]);
	}
   
	// Return contacts of the given like parameters with a map
	public map<String, Contact> getContactsByMap(List<Contact> contactsList){
   	map<String, Contact> result = new map<String, Contact>();
  	 
   	for(Contact myContact : contactsList){
       		result.put(myContact.Email, myContact);
   	}
  	 
   	return result;
	}
}