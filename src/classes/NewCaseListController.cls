public class NewCaseListController {
	public List<Case> getNewCases(){
		
		List<Case> newCases = new List<Case>();
		
		for(Case cases: [
            select Id, CaseNumber, Status
            from Case 
        ]){
            if(cases.Status=='New') newCases.add(cases);
        }
        
		return newCases;
	}   
}