/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/
({
    // get call center settings, to get the information about the call provider
    // then use open CTI to screen pop to the record, and runApex() to make a call
    screenPopAndCall : function(cmp) {
    	if(window.conn.state != '1'){
    		var number = cmp.get('v.phone');
    		number = number.replace(/ /gi, '').replace(/-/gi,'').replace(/\(/gi, '').replace(/\)/gi, '').replace(/\+/gi, '');
    		//number = '82' + number.substring(1);
    		var params = {
    				"PhoneNumber" : number
    		};
    		window.conn.call(number);
    		//alert('outbound call is under construction!');
    	}
    	sforce.opencti.screenPop({
    		type : sforce.opencti.SCREENPOP_TYPE.SOBJECT,
    		params : { recordId : cmp.get('v.recordId') },
    		callback : function(response) {
    			cmp.getEvent('editPanel').setParams({
    				label : 'CTI Softphone: ' + cmp.get('v.state')
    			}).fire();
    		}
    	})
    },

    // on Accept, accept the call by bringing up the Connected Panel
    renderConnectedPanel : function(cmp){
        var recordId = cmp.get('v.recordId');
        var account = cmp.get('v.account');
        cmp.getEvent('renderPanel').setParams({
            type : 'c:windConnectedPanel',
            attributes : {
                showDialPad : false,
                recordId : recordId,
                callType : 'Inbound',
                account : account,
                recordName: cmp.get('v.recordName'),
                presence : cmp.get('v.presence')
            }
        }).fire();
    }
})