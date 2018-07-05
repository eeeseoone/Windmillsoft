public class BBS_Component_Controller {
    
    /* 
    @AuraEnabled
    public static String getBoard(String recordId){ //id is the parameter
        
        List<One_s_Board__c> BbsList = new List<One_s_Board__C>();
        for(One_s_Board__c board: [
            select id, CreatedDate, title__c, content__c 
            from One_s_Board__c 
            where id =: recordId
        ]){
            BbsList.add(board);
        }
        String JSONString = JSON.serialize(BbsList);            
        return JSONString; 
    }
    */
    
    @AuraEnabled
    public static List<One_s_Board__c> getBoard(String recordId){ //id is the parameter
        
        List<One_s_Board__c> BbsList = new List<One_s_Board__C>();
        for(One_s_Board__c board: [
            select id, CreatedDate, title__c, content__c 
            from One_s_Board__c 
            where id =: recordId
        ]){
            BbsList.add(board);
        }
        
        return BbsList;
    }
        
    @AuraEnabled
    public static List<User> getAuthor(String recordId){
    	
    	List<User> UserList = new List<User>();
    	
  		One_s_Board__c brd = [select CreatedById  //cannot be a statement
  					from One_s_Board__c
  					where Id =: recordId ];
  					
        for(User user: [
           select Name 
            from User 
            where Id =: brd.CreatedById ] 
        ){
            UserList.add(user);
        }
/*        String JSONString = JSON.serialize(UserList);        
        return JSONString;*/
        return UserList;
    }
}