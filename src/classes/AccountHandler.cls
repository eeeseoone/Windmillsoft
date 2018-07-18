public with sharing class AccountHandler {
	
	public static Account insertNewAccount(String S){

		Account acct;		
		
		try{
		acct = new Account(Name=S , Phone='010-2648-2731');
		insert acct;
			
		}catch (DmlException e){
			System.debug('A DML exception has occurred:: ' + e.getMessage());
			acct = null;
		}
		
		System.debug('acct: '+acct);
		return acct;
			
	}
    
}