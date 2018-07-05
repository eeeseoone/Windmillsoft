/**************************************************************************************** 
 * File Name    : SoftphoneContactSearchController
 * Function     : Search Contact
 * Author       : KJ.Hyun
 * Date         : 2018.06.04
 * Tester       : SoftphoneContactSearchControllerTest
 * Page         : 
 * Target       : 
 * Description  : 
 * Modification Log
 * =============================================================== 
 * Ver  Date        Author     Modification
 * ===============================================================
   1.0  2018.06.04  KJ.Hyun     Create
****************************************************************************************/
global class SoftphoneContactSearchController {
    webService static String getContacts(String name) {
        List<Contact> contactList = new List<Contact>();
        for (Contact contact: [
        						SELECT Id, Phone, Name, Title, Account.Name 
        						FROM Contact 
        						WHERE (id = :name OR Name LIKE :('%' + name + '%') 
        						OR firstname LIKE :('%' + name + '%') 
        						OR lastname LIKE :('%' + name + '%') 
        						OR phone LIKE :('%' + name + '%')) LIMIT 10]){
            contactList.add(contact);
        }
        return JSON.serialize(contactList);
    }
}