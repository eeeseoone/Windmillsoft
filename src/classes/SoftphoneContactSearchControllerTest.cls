/**************************************************************************************** 
 * File Name    : SoftphoneContactSearchControllerTest
 * Function     : Search Contact
 * Author       : KJ.Hyun
 * Date         : 2018.06.04
 * Target       : SoftphoneContactSearchController
 * Description  : 
 * Modification Log
 * =============================================================== 
 * Ver  Date        Author     Modification
 * ===============================================================
   1.0  2018.06.04  KJ.Hyun     Create
****************************************************************************************/
@isTest(SeeAllData=true)
private class SoftphoneContactSearchControllerTest {

    private static testMethod void testGetContacts() {
        // ANI to search on
        string ANI = '1234567890';
        // Create Contact
        Contact contact = new Contact();
        contact.FirstName = 'Test' + DateTime.now();
        contact.LastName = 'SoftphoneContactSearchControllerTest';
        contact.phone = ANI;
        insert contact;
        try {
            // Test contact query method
            System.assert(SoftphoneContactSearchController.getContacts(ANI).contains(ANI), 'Result should contain at least one contact with ANI');
        } finally {
            // Delete Contact
            delete contact;
        }
    }
}