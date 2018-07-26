trigger AccountAddressTrigger on Account (before insert, before update) {
    
    for(Account myAcc : Trigger.new){
    	if(myAcc.Match_Billing_Address__c == true){
    		if(myAcc.ShippingPostalCode != null && myAcc.BillingPostalCode == null){
    			myAcc.BillingPostalCode  = myAcc.ShippingPostalCode;
    		}else if(myAcc.BillingPostalCode != null && myAcc.ShippingPostalCode == null){
    			myAcc.ShippingPostalCode = myAcc.BillingPostalCode;
    		}
    	}
    }
}