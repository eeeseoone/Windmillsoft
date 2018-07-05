/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
  // log a task for the call
  logCall : function(cmp, callback) {
    var component = cmp;
    if ($A.util.isEmpty(component.get('v.recordId')) || cmp.get('v.showDialPad')){
    	console.log('callback ----------------------------');
    	callback();
    } else {
      cmp.find("ticker").getDurationInSeconds(function(duration) {
    	  console.log('logCall');
        sforce.opencti.saveLog({
          value : {
            entityApiName : 'Task',
            WhoId : cmp.get('v.recordId'),
            CallDisposition : 'Internal',
            CallObject : 'DemoCall',
            Description : component.find('note').get('v.value'),
            Subject : 'Demo Call Log',
            Priority : 'Normal',
            Status : 'Completed',
            CallDurationInSeconds : duration,
            CallType : cmp.get('v.callType'),
            Type : 'Call',
            WhatId : cmp.get('v.account').Id
          },
          callback : callback
        });
      })
    }
  },
})