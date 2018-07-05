/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // initialize the keys (digits, letters, and signs) on the dialpad
    init: function(cmp, event, helper) {
        cmp.set('v._keys', helper.getKeyList());
    },

    // click handler
    handleClick: function(cmp, event) {
        var sourceElem = event && event.currentTarget;
        var value = sourceElem && sourceElem.getAttribute('data-value');
        if (value) {
            cmp.get('e.keyClick').setParams({value: value}).fire();
        }
    }
})