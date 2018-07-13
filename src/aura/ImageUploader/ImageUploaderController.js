({
	handleUploadFinished: function (component, event) {
		console.log('now we are in js controller');
        // Get the list of uploaded files
        var uploadedFiles = event.getParam("files");
        //set action to call updatePicturePath method from Server-side controller
        var action = component.get("c.updatePicturePath");
        action.setParams({
            recId : component.get("v.recordId")
        });
        action.setCallback(this, function(a){
        	if(a.getState() === "SUCCESS"){
        		alert('success! hooray!');
            	var resultToast = $A.get("e.force:showToast");
        		resultToast.setParams({
                            "title": "Success!",
                            "message": uploadedFiles.length + "file uploaded successfully."
                        });
                        console.log('resultToast: ' + resultToast);
        		resultToast.fire();;
        	}else{ //대리님이 알려주신 에러 디버깅하는 방법 
        		console.log('state : ' + a.getState());
        		var error = a.getError();
        		console.log('error : ' + error[0].message);
        	}
        });
    	$A.enqueueAction(action);
    }
})