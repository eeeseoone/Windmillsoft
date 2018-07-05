({
	doInit : function(component, event, helper) {
		console.log("holla horchatta");
		/*   
		 component.set('v.board',[]); //빈 오브젝트로 저장 
		 component.set('v.author',[]); //빈 오브젝트로 저장
		 */
		/*------------------------Board------------------------*/
		var actionBoard = component.get("c.getBoard"); //client-side controller에서 어떤 액션을 취할건지 정의해줌        

		actionBoard.setParams({ //여기서 클래스로 보낼 파라미터 셋팅
			recordId : component.get("v.recordId")
		});
		actionBoard.setCallback(this, function(response) {
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {
				//alert the user with the value returned
				//여기서 alert가 된다는 것은, 일단 recordId무사히 받은거고
				//apx -->getBoard메소드 잘 타서 json으로 데이터까지 잘 왔다는 뜻
				//여기서 parsing만 잘해서 마크업으로 넘겨주면 되는데ㅜㅜㅜ        
				alert("From server1: " + response.getReturnValue());//여기까진 문제없이 떴음
				var returnValue = response.getReturnValue();

				console.log('>> JSON.stringify(returnValue): '
						+ JSON.stringify(returnValue));
				component.set('v.board', returnValue);
			} else {
				console.log("Failed with state: " + state);
			}
		});
		$A.enqueueAction(actionBoard);

		/*------------------------Author------------------------*/
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

	}
})