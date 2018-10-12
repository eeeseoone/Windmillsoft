public class test {

    public String testMessage {get; set;}
    public String jsonTxt {get; set;}
	public Integer status {get;set;}
	
    public void init(){ 
        testMessage = ApexPages.currentPage().getParameters().get('test');
		//JSON = 'hi';
		
		try{
			HttpRequest req = new HttpRequest();
			HttpResponse res = new HttpResponse();
			Http http = new Http();
			
			req.setEndpoint('https://onelivechat-developer-edition.ap5.force.com');
			req.setMethod('GET');
			res = http.send(req); 
			if(res.getStatusCode() == 200){
				//deserialize the JSON string into collections of primitive data types
				jsonTxt = res.getBody();
				System.debug(jsonTxt);
				status = res.getStatusCode(); 

			} 
        }catch(Exception e){ 
        	System.debug('Error: ' + e.getMessage() + 'LN: '+e.getLineNumber() );
        }	
        
    }
}