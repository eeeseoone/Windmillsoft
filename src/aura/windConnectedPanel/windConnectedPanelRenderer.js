/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    afterRender: function(component){
        this.superAfterRender();
        if ($A.util.isEmpty(component.get('v.recordId'))){
            component.find('note').set('v.disabled',true);
            component.find('note').set('v.placeholder',"You can’t enter notes for unknown contacts. ");
        }
    }
})