/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // populate the values of the status dropdown
    init: function(cmp, event, helper) {
        var presence = cmp.get('v.presence');
        var states = { 'Available' : 'available',
                       'Busy' : 'warning',
                       'Unavailable': 'error'};
        var iconType = states[presence];
        helper.renderIcon(cmp, iconType);
        var arr = [];
        for (var property in states) {
            if (states.hasOwnProperty(property)) {
            	arr.push({status : property, iconType : states[property]})
            }
        }
        cmp.set('v.states', arr);
        helper.setLabel(cmp, 'CTI Softphone: '+presence);
    },

    // expand the status dropdown on click
    toggleStatus: function (cmp, event, helper) {
        helper.toggleStatus(cmp);
    },

    // update the status/presence by firing the onlinePresenceChanged event
    handleSelection: function (cmp, event, helper) {
        var selectedOption = event.currentTarget;
        helper.setStatusName(cmp, selectedOption);
        helper.toggleStatus(cmp);
        helper.setLabel(cmp, 'CTI Softphone: '+selectedOption.getAttribute('data-value-name'));
        helper.notifyPhonePanel(cmp, helper, selectedOption.getAttribute('data-value-name'));
    },

    // on log out
    handleLogout: function(cmp, event, helper) {
        helper.handleLogout(cmp);
    }
})