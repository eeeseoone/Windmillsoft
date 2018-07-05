/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // screen pop to the contact home, and use the call provider to make a call
    init : function(cmp, event, helper) {
        helper.screenPopAndCall(cmp);
    },

    // On incoming calls, this is a handler for the Accept button
    accept : function(cmp, event, helper) {
    	var conn = window.conn;
        if(conn){
        	conn.answer();
        	helper.renderConnectedPanel(cmp);
        }else{
        	cmp.getEvent('renderPanel').setParams({
        		type : 'c:windPhonePanel',
        		toast : {'type': 'warning', 'message': 'Call was declined.'},
        		attributes : { presence : 'Available' }
        	}).fire();
        }
    },

    // On incoming calls, this is a handler for the Decline button
    // taking you back to the phone panel
    decline : function(cmp, event, helper) {
        var conn = window.conn;
        if(conn){
        	conn.reject();
        }
        cmp.getEvent('renderPanel').setParams({
            type : 'c:windPhonePanel',
            toast : {'type': 'warning', 'message': 'Call was declined.'},
            attributes : { presence : 'Available' }
        }).fire();
    },

    // On dialing calls, this is a handler for the End button
    // taking you back to the phone panel
    end : function(cmp, event, helper) {
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
        cmp.getEvent('renderPanel').setParams({
            type : 'c:windPhonePanel',
            toast : {'type': 'normal', 'message': 'Call was ended.'},
            attributes : { presence : 'Available' }
        }).fire();
    },
})