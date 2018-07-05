/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
  // sets the initial attributes and updates the duration every second
  init: function(cmp, event, helper){
    cmp.set('v.duration', '0:00');
    cmp.set('v.seconds', 0);
    cmp._intervalID=null;
    var start=null;

    function tick(){
      if (!cmp.isValid()){
        return;
      }
      var now=new Date();
      var diff=now.getTime()-start.getTime();
      diff=diff/1000;

      var duration=cmp.get('v.duration');
      var newDuration=helper.formatSecond(diff);
      if (duration!=newDuration){
        cmp.set('v.duration', newDuration);
        cmp.set('v.seconds', diff);
      }
    }
    var tickBack=$A.getCallback(tick);
    start=new Date();
    cmp._intervalID= window.setInterval(tickBack, 1000);
  },

  // return duration in seconds (for example, when duration is 10:06, it will return 606)
  getDurationInSeconds: function(cmp, event) {
    var params = event.getParam('arguments');
    if (params) {
        params.callback(cmp.get('v.seconds'));
    }
  }
})