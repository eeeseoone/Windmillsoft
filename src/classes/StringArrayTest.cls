public class StringArrayTest{
	
	public static List<String> generateStringArray(integer num){

		List<String> OldArray = new List<String>();
		
		for(Integer i=0; i<num; i++){
			OldArray.add('Test '+ String.valueOf(i));
			system.debug(OldArray[i]);
		}
		return OldArray;
		
	}
}