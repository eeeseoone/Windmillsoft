/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
	// converts from seconds to the HH:MM:SS format
	formatSecond: function(totalseconds){
		var seconds=Math.floor(totalseconds%60);
		var hour=Math.floor(totalseconds/3600);
		var minutes=Math.floor( (totalseconds%3600)/60);

		var  finalStr='';
		if (hour>0){
			finalStr+=hour;
			finalStr+=':';
		}
		finalStr+=minutes;
		finalStr+=':';

		finalStr+=(seconds>=10?seconds:'0'+seconds);
		return finalStr;
	},

})