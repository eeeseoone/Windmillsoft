/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // set the panel label to Open CTI: Connected
    init: function(cmp, event, helper) {
        cmp.set('v.conn', window.conn);
        cmp.getEvent('editPanel').setParams({
            label : 'CTI Softphone: Connected'
        }).fire();
    },

    // a handler for the dial pad icon, showing or hiding the dial pad
    toggleDialPad: function(cmp, event, helper) {
        cmp.set('v.showDialPad', !cmp.get('v.showDialPad'));
        cmp.set('v.inputValue', '');
    },

    // log a task, unless the record is unrecognized, and return to phone panel when ending a call
    endCall: function(cmp, event, helper) {
    	console.log('endCall');
        
    	helper.logCall(cmp, function(response) {
    		cmp.getEvent('renderPanel').setParams({
    			type : 'c:windPhonePanel',
    			toast : {'type': 'normal', 'message': 'Call was ended.'},
    			attributes : { presence : 'Available'}
    		}).fire();
    		/*Twilio.Device.disconnectAll();*/
    		if(window.conn){
    			console.log('hangup ------------------------');
    			window.conn.hangup();
    			/*
    			if(window.conn.session){
    				console.log('terminate ------------------------');
    				window.conn.session.terminate();
    			}
				*/
    		}
    		var param = {};
    		var callback = function(response) {
    			if (response.success) {
    				console.log('API method call executed successfully! returnValue:', response.returnValue);
    			} else { 
    				console.error('Something went wrong! Errors:', response.errors);
    			}
    		};
    		param.callback = callback;
    		
    		sforce.opencti.refreshView(param);
    	});
    },

    // update search bar with every key click, and update the status of the Call button
    handleKeyClick: function(cmp, event, helper) {
        cmp.set('v.inputValue', cmp.get('v.inputValue') + event.getParam('value'));
        cmp.set('v.transfercallDisabled', false);
    },

    transferCall: function(cmp, event, helper) {
        cmp.getEvent('renderPanel').setParams({
              toast : {'type': 'normal', 'message': 'Call was transferred to '+ cmp.get('v.inputValue') +'.'},
        }).fire();
    },
})