/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    // bring up the help window
    showModal : function(cmp, event, helper) {
        // TODO: Try not to reference `document`.
        document.getElementById('backGroundSectionId').style.display = 'block';
    },

    // close the help window
    showHelp : function(cmp, event, helper) {
        // TODO: Try not to reference `document`.
        document.getElementById('backGroundSectionId').style.display = 'none';
    }
})