({
	doEdit: function(component,event,helper){
	
		console.log("now we're editing");
		
		var actionEdit = component.get("c.getBord");
		
		actionEdit.setParams({
			recordId : component.get("v.recordId")
		});
		actionEdit.setCallback(this, function(response){
			var state = response.getState();
			if(component.isValid() && state === "SUCCESS"){
				var returnValue = response.getReturnValue();
				component.set('v.board')
			}
		})
	},
	
    onSuccess: function(component,event,helper){
        //Show Success message on upsertion of record
        var resultToast = $A.get("e.force:showToast");
        resultToast.setParams({
                            "title": "Success!",
                            "message": "Record Saved Successfully"
                        });
        resultToast.fire();
        //Navigate to sObject home page
        var homeEvent = $A.get("e.force:navigateToObjectHome");
    	homeEvent.setParams({
        	"scope": "One_s_Board__c"
    	});
    	homeEvent.fire();
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
})