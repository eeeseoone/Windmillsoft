/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // show spinner until the panel is fully rendered
    // render panel of a certain type (i.e. c:windPhonePanel)
    // optionally, show a toast on top of the new component
    renderPanel : function(cmp, params) {
        cmp.set('v.showSpinner', true);
        console.log(params);
        if (params.toast) {
            cmp.find('toast-message').set('v.content', params.toast);
        }
        if (params.type) {
            $A.createComponent(params.type, params.attributes, function(newPanel) {
                if (cmp.isValid()) {
                    cmp.set('v.body', [ newPanel ]);
                    cmp.set('v.showSpinner', false);
                }
            });
        } else {
            cmp.set('v.showSpinner', false);
        }
    },

    // use open CTI to update the panel label
    setPanelLabel : function(cmp, panelLabel) {
        if (panelLabel) {
            sforce.opencti.setSoftphonePanelLabel({
                label : panelLabel
            });
        }
    },
    
    // first time this method is called, it will fetch the settings using opencti.getCallCenterSettings 
    getCallCenterSettings: function(cmp, callbackFunc) {
        if (callbackFunc && cmp.get('v.settings')) {
            callbackFunc(cmp.get('v.settings'));
        } else {   //first time call
            sforce.opencti.getCallCenterSettings({
                callback : function(response) {
                    if (response.success) {
                        cmp.set('v.settings', response.returnValue);
                        callbackFunc(cmp.get('v.settings'));
                    } else {
                        throw new Error(
                            'Unable to load call center settings. Contact your admin.')
                    }
                }
            })
        }
   },
   
   // perform search using Open CTI runApex()
    // optionally run a callback function on completion
    search : function(cmp, number, onCompletion) {
        var args = {
            apexClass : 'SoftphoneContactSearchController',
            methodName : 'getContacts',
            methodParams : 'name=' + number,
            callback : function(result) {
                if (result.success) {
                    var searchResults = JSON.parse(result.returnValue.runApex);
                    onCompletion && onCompletion(cmp, searchResults[0]);
                } else {
                    throw new Error(
                            'Unable to perform a search using Open CTI. Contact your admin.');
                }
            }
        };
        sforce.opencti.runApex(args);
    },
    
    // perform search using Open CTI runApex()
    // optionally run a callback function on completion
    cleanFormatting : function(cmp, event, conn) {
    	/*var number = conn.parameters.From;*/
    	var number = window.conn.session.request.headers.From[0].raw.split('"')[1];
    	/*alert(number);*/
    	number = number.replace(/ /gi, '').replace(/-/gi,'').replace(/\(/gi, '').replace(/\)/gi, '').replace(/\+/gi, '');
		if(number.indexOf('82')==0){
			number = '0' + number.substring(2);
		}
		return number;
    }

})