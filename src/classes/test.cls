public class test {

    public String testMessage {get; set;}
    public String json {get; set;}
	public Integer status {get;set;}
	
    public void init(){ 
        testMessage = ApexPages.currentPage().getParameters().get('test');
		JSON = 'hi';
		
		try{
			HttpRequest req = new HttpRequest();
			HttpResponse res = new HttpResponse();
			Http http = new Http();
			
			req.setEndpoint('https://onelivechat-developer-edition.ap5.force.com');
			req.setMethod('GET');
			res = http.send(req);
			if(res.getStatusCode() == 200){
				System.debug(res.getStatusCode());
				status = res.getStatusCode();
				json = String.valueOf(res.getBodyAsBlob());
			} 
        }catch(Exception e){ 
        	System.debug('Error: ' + e.getMessage() + 'LN: '+e.getLineNumber() );
        }	
        
    }
}