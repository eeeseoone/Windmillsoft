({
	doInit : function(component, event, helper) {
		console.log("hola horchata");

		/*------------------------Board------------------------*/
		var actionBoard = component.get("c.getBoard"); //client-side controller에서 어떤 액션을 취할건지 정의해줌        

		actionBoard.setParams({ //여기서 클래스로 보낼 파라미터 셋팅
			recordId : component.get("v.recordId")
		});
		actionBoard.setCallback(this, function(response) {
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {
				//alert("From server1: " + response.getReturnValue());//여기까진 문제없이 떴음
				var returnValue = response.getReturnValue();

				console.log('>> JSON.stringify(returnValue): ' + returnValue);
				component.set('v.board', JSON.parse(returnValue));
			} else {
				console.log("Failed with state: " + state);
			}
		});
		$A.enqueueAction(actionBoard);

	}
})






/*
		------------------------Author------------------------
		var actionAuthor = component.get("c.getAuthor"); //UserList를 리턴

		actionAuthor.setParams({
			recordId : component.get("v.recordId")
		});
		actionAuthor.setCallback(this, function(response) {
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {
				alert("From server2: " + response.getReturnValue());
				var returnValue = response.getReturnValue();

				console.log('>> JSON.stringify(returnValue): '
						+ JSON.stringify(returnValue));
				component.set('v.author', returnValue);
			} else {
				console.log("Failed with state: " + state);
			}
		});
		$A.enqueueAction(actionAuthor);
*/