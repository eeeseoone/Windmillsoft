public class VO_Opportunity {
	
    public Id 		Id						;
	public String 	opportunityName       	;
	public String 	opportunityNumber     	;
	public String 	sapCustomerId        	;
	public String 	accouontName          	;
	public String 	primaryAeTsr         	;
	public String 	opportunityType         ;
	public String 	primaryCampaignSource	;
	public String 	amountCurrency        	;
	public double 	amount                 	;
	public String 	primarySalesProject  	;
	public String 	leadSource            	;
	public Date		closeDate             	;
	public double 	stageName             	;
	public double 	age                    	;
	public Date		createdDate           	;
	public String 	opportunityOwner      	;
	public String 	ownerRole             	;
	public String 	closedLostReasonCode	;
	public String 	closedWonReasonCode 	;
	    
    public VO_Opportunity(SObject sob) {
       this.Id = sob.Id;
//       this.Name = (String) sob.get('Name');
    }
}