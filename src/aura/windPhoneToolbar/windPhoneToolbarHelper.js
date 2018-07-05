/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
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
})