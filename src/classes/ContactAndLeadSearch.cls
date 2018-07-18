public with sharing class ContactAndLeadSearch {
	
    public static List<List< SObject>> searchContactsAndLeads(String str){
    	
    	String searchQuery = 'FIND \'' + str + '\' IN ALL FIELDS RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)'; 
		List<List<sObject>> searchList = search.query(searchQuery);
		return searchList;
    }
}