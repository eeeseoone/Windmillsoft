/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // adds an onCLickToDial listener
    // This listener brings up the softphone every time click to dial is fired
    // and renders the callInitiatedPanel panel with the event payload
    handleOutgoingCalls : function(cmp) {
        var listener = function(payload) {
            sforce.opencti.setSoftphonePanelVisibility({
                visible : true,
                callback : function() {
                    if (cmp.isValid() && cmp.get('v.presence') != 'Unavailable') {
                        var attributes = {
                            'state' : 'Dialing',
                            'recordName' : payload.recordName,
                            'phone' : payload.number,
                            'title' : '',
                            'account' : '',
                            'presence' : cmp.get('v.presence')
                        };
                        cmp.getEvent('renderPanel').setParams({
                            type : 'c:windCallInitiatedPanel',
                            attributes : attributes
                        }).fire();
                    }
                }
            });
        };
        sforce.opencti.onClickToDial({
            listener : listener
        });
    },

    // toggles the Call button from disabled to enabled, if the input number is valid
    updateButtonStatus : function(cmp) {
        if (this.isValidPhoneNumber(cmp)) {
             cmp.set('v.callDisabled',false);
        } else {
             cmp.set('v.callDisabled',true);
        }
    },

    // returns true if phone number is a valid integer, i.e. at least 3 digits
    isValidPhoneNumber : function(cmp) {
        var inputValue = cmp.get('v.inputValue');
        return (inputValue.length >= 3 && !isNaN(parseFloat(inputValue)) && isFinite(inputValue));
    },

    // find a matching record for a number
    // if there's a match - initiate call panel with record details
    // if not, initiate call panel with only number and state
    callNumber : function(cmp, number) {
        var attributes = {
            'state' : 'Dialing',
            'recordName' : number
        };
        var record = cmp.get('v.searchResults')
                && cmp.get('v.searchResults')[0];

        if (record && this.matchingNumbers(number, record.Phone)) {
            attributes.recordName = record.Name;
            attributes.phone = record.Phone;
            attributes.title = record.Title;
            attributes.account = record.Account;
            attributes.recordId = record.Id;
        }else{
        	attributes.phone = number;
        }
        cmp.set('v.searchResults', []);
        this.initiateCallPanel(cmp, attributes);
    },

    // strip alphabetic characters from numbers and returns true if numbers are matching
    matchingNumbers : function(number1, number2){
        var target = number2.replace(/\D/g,'')
        return number1.replace(/\D/g,'') == target && target.length > 0;
    },

    // when clicking on a contact card, initiate call panel with contact card details
    callContact : function(cmp, record) {
        if (!record ) {
            throw new Error('Something went wrong. Try again or contact your admin.');
        };
        var attributes = {
            'state' : 'Dialing',
            'recordName' : record.Name,
            'phone' : record.Phone,
            'title' : record.Title,
            'account' : record.Account,
            'recordId' : record.Id
        };
        this.initiateCallPanel(cmp, attributes);
    },

    // find a matching record using Open CTI runApex()
    // optionally run a callback function onCompletion
    search : function(cmp, inputValue, onCompletion) {
        cmp.set('v.searchResults', []);
        if (inputValue.length < 2) {
            cmp.set('v.message', 'Enter at least two characters');
            return;
        };
        var args = {
            apexClass : 'SoftphoneContactSearchController',
            methodName : 'getContacts',
            methodParams : 'name=' + inputValue,
            callback : function(result) {
                if (result.success) {
/*여기서 json 파싱*/
                    var searchResults = JSON.parse(result.returnValue.runApex);
                    console.log(searchResults);
                    cmp.set('v.searchResults', searchResults);
                    if (searchResults.length == 0) {
                        cmp.set('v.message', 'No results found');
                    }
                    onCompletion && onCompletion(cmp, inputValue);
                } else {
                    throw new Error('Unable to perform a search using Open CTI. Contact your admin.');
                }
            }
        };
        sforce.opencti.runApex(args); //javascript library: 콘솔화면의 기능들을 컨드롤할 수 있는 function들을 모아놓은 세일즈포스에서 제공하는 것
    },

    // sets the presence to the new presence
    // and updates the message on the phone panel based on the new presense
    updatePresence : function(cmp, event, helper) {
        var newStatus = event.getParams().newStatus;
        cmp.set('v.presence', newStatus);
        var newMessage = 'Search for a contact';
        if (newStatus === 'Unavailable') {
            newMessage = "You're currently unavailable for calls";
            cmp.set('v.showDialPad',false);
        }
        cmp.set('v.message', newMessage);
    },

    // renders the callInitiatedPanel panel
    initiateCallPanel : function(cmp, attributes) {
        attributes.presence = cmp.get('v.presence');
        cmp.getEvent('renderPanel').setParams({
            type : 'c:windCallInitiatedPanel',
            attributes : attributes
        }).fire();
    }
})