/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // on initialization, get the Call Center Settings and enable click to dial
    init: function(cmp, event, helper) {
        cmp.set('v.searchResults', []);
        helper.handleOutgoingCalls(cmp);
    },

    // dial from dial pad: first check for a matching record, and then dial it
    searchAndCallNumber: function(cmp, event, helper) {
        var number = cmp.get('v.inputValue'); //다이얼패드에 입력한 번호를 number로 저장
        helper.search(cmp, number, function(cmp, number){ //헬퍼의 search와 callNumber를 호출.
            helper.callNumber(cmp, number);
        });
    },

    // when you hit Enter, if it's a valid phone number, check for a matching record, and then dial it.
    // otherwise, search and display search results
    handleKeyUp: function(cmp, event, helper) {
    	console.log(event.getParams().keyCode);
        if (event.getParams().keyCode == 13) { //enter
            cmp.set('v.showDialPad', false);
            var inputValue = cmp.get('v.inputValue');
            if (helper.isValidPhoneNumber(cmp)) {
                helper.search(cmp, inputValue, function(cmp, inputValue){
                    helper.callNumber(cmp, inputValue);
                });
            } else {
                helper.search(cmp, inputValue);
            }
        }
    },

    // update search bar with every key click, and update the status of the Call button
    handleKeyClick: function(cmp, event, helper) {
        cmp.set('v.inputValue', cmp.get('v.inputValue') + event.getParam('value'));
        helper.updateButtonStatus(cmp);
    },

    // handler for the dial pad icon, toggle dial pad on click
    toggleDialPad: function (cmp, event, helper) {
        var showDialPad = !cmp.get('v.showDialPad');
        cmp.set('v.showDialPad', showDialPad);
        cmp.set('v.inputValue', '');
        cmp.set('v.searchResults', []);
        if (showDialPad) {
            var toggleMessage = cmp.find("message");
            $A.util.toggleClass(toggleMessage, "toggle");
        }
    },

    // handler for the onlinePresenceChanged event. fired when the value of status dropdown is changing.
    onOnlinePresenceChanged: function (cmp, event, helper) {
         helper.updatePresence(cmp, event, helper);
    },

    // this method is called when once clicks on a search result card
    handleSelectCard: function (cmp, event, helper) {
        var index = event.currentTarget.getAttribute('data-value');
        var selectedRecord = cmp.get('v.searchResults')[index];
        if (!selectedRecord.Phone) {
            cmp.set('v.searchResults', []);
            cmp.set('v.message', "This contact doesn't have a phone number");
        } else {
            helper.callContact(cmp, selectedRecord);
        }
    },
})