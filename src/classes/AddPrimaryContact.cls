public class AddPrimaryContact implements Queueable {

private Contact contact;
private String state;

 	public AddPrimaryContact(Contact contact, String state){
 		this.contact = contact;
 		this.state = state;
 	}
/*
The execute method must query 
for a maximum of 200 Accounts 
with the BillingState specified 
by the State abbreviation passed 
into the constructor and 

insert the Contact sObject record 
associated to each Account. 

Look at the sObject clone() method.
*/
    public void execute(QueueableContext context){
    		
    		List<Account> ListAccount = [SELECT ID, Name ,
						    			(Select Id,FirstName,LastName from Contacts ) 
						    			FROM ACCOUNT WHERE BillingState = :state LIMIT 200];
		List<Contact> ListContact = new List<Contact>();
		
		for(Account acc: ListAccount){
			Contact cont = contact.clone(false,false,false,false);
			cont.AccountId = acc.id;
			ListContact.add(cont);
		}
		if(ListContact.size() > 0){
			insert ListContact;
		}


    }
}