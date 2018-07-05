/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // store call center settings, so they're easily accessible ny all panels. Bring up the CTI login panel.
    init: function(cmp, event, helper) {
        var callback = function() {
		            cmp.getEvent('renderPanel').setParams({
		                type : 'c:windPhonePanel',
		                attributes: { presence : 'Available'}
		            }).fire();
		        };
        sforce.opencti.enableClickToDial({callback: callback});
    },

    // renderPanel event handler. Used to replace the current view with a given panel.
    renderPanel: function(cmp, event, helper) {
        var params = event.getParams();
        helper.renderPanel(cmp, params);
    },

    // getSettings event handler. Returns the stored call center settings.
    getSettings: function(cmp, event, helper) {
        var callback = event.getParams().callback;
        helper.getCallCenterSettings(cmp, callback);
    },

    // editPanel event handler. Updates the softphone panel label.
    editPanel: function(cmp, event, helper) {
        var params = event.getParams();
        if (params.label) {
            sforce.opencti.setSoftphonePanelLabel({
                label: params.label
            });
        }
    },

    // initialize incomming call.
    setIncommingCall: function(cmp, event, helper) {
    	var conn = window.conn;
/*    	var conn = event.getParams().conn;*/
    	var number = helper.cleanFormatting(cmp, event, conn);
        helper.search(cmp, number, function(cmp, result) {
            var record = result ? result : {
                Name : number
            };
            cmp.getEvent('renderPanel').setParams({
                type : 'c:windCallInitiatedPanel',
                attributes : {
                    'state' 		: 'Incoming',
                    'recordName' 	: record.Name,
                    'phone' 		: record.Phone,
                    'title' 		: record.Title,
                    'account' 		: record.Account,
                    'recordId' 		: record.Id,
                    //'conn' 			: conn,
                    'presence' 		: cmp.get('v.presence')
                }
            }).fire();
        })
    }
})