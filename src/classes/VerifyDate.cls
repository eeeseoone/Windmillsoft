public class VerifyDate {
	
	//method to handle potential checks against two dates
	public static Date CheckDates(Date date1, Date date2) {
		//if date2 is within the next 30 days of date1, use date2.  Otherwise use the end of the month
		if(DateWithin30Days(date1,date2)) {
			return date2;
		} else {
			return SetEndOfMonthDate(date1);
		}
	}
	
	
	
	//method to check if date2 is within the next 30 days of date1
	@TestVisible
	private static Boolean DateWithin30Days(Date date1, Date date2) {
		//check for date2 being in the past
        	if( date2 < date1) { return false; }
        
        	//check that date2 is within (>=) 30 days of date1
        	Date date30Days = date1.addDays(30); //create a date 30 days away from date1
		if( date2 >= date30Days ) { return false; }
		//date2가 date1 보다 크면 X, 또 date1로부터 30일 초과 된 경우도 X
		else { return true; }
	}

	//method to return the end of the month of a given date
	@TestVisible
	private static Date SetEndOfMonthDate(Date date1) {
		//해당 월에 며칠이 포함되어있는지 알아내는 식.
		Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		//마지막 달을 년/월/일로 추출 
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
		return lastDay;
	}

}