/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // expand the status dropdown on click
    toggleStatus: function(cmp) {
        var dropdown = cmp.find('dropdownContainer');
        $A.util.toggleClass(dropdown, 'slds-is-open');
    },

    // update the status dropdown (presence and icon)
    setStatusName: function(cmp, selectOption) {
        var newStatus = selectOption.getAttribute('data-value-name');
        var iconType = selectOption.getAttribute('data-value-iconType');
        cmp.set('v.presence', newStatus);
        this.renderIcon(cmp, iconType);
    },

    // update the status icon on the first row of the status dropdown
    renderIcon : function(cmp, iconType) {
        $A.createComponent("c:windSvg",
            {"class": 'slds-icon slds-icon--x-small slds-icon-text-'+iconType,
            "aura:id": "statusIcon",
            "xlinkHref": "/resource/slds/assets/icons/utility-sprite/svg/symbols.svg#record"},
            function(newIcon) {
                if (cmp.isValid()) {
                    cmp.set('v.icon', [ newIcon ]);
                }
            });
    },

    // on logout, disable click to dial and bring up the cti login panel
    handleLogout: function(cmp) {
        var callback = function(result) {
            if (result.success) {
                cmp.getEvent('renderPanel').setParams({
                    type: 'c:windPhonePanel'
                }).fire();
            } else {
                throw new Error('Click to dial cannot be disabled.');
            }
        };
        sforce.opencti.disableClickToDial({
            callback: callback
        });
    },

    // set the panel label by firing the editPanel event
    setLabel: function (cmp, label) {
        cmp.getEvent('editPanel').setParams({
                label: label
        }).fire();
    },

    // notify the phone panel that the presence has changed
    notifyPhonePanel: function(cmp, helper, newStatus) {
        cmp.getEvent('onlinePresenceChanged').setParams({
            newStatus: newStatus
        }).fire();
    }
})