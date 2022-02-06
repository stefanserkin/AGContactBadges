@isTest
private class ContactBadgesController_Test {

    private static Id hhRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('HH_Account').getRecordTypeId();
    private static Id donationRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId();
    private static List<Contact_Badge_Definition__mdt> lstDefinitions = Contact_Badge_Definition__mdt.getAll().values();

    @isTest
    static void testBadgesFromController() {

        BadgeDataWrapperService.isTestScenario = true;

        Account acc = new Account(Name='Wright Household', RecordTypeId=hhRecTypeId);
        insert acc;

        Contact ct = new Contact(AccountId=acc.Id, FirstName='David', LastName='Wright', Email='capn@mets.com', Birthdate=Date.today(), Title='Third Basemen');
        insert ct;
        
        Test.startTest();
        List<BadgeDataWrapperService.BadgeDataWrapper> wrapperResult = ContactBadgesController.getBadgeData(ct.Id, acc.Id);
        Test.stopTest();

        Boolean foundMetsBadge = false;
        Boolean foundBirthdayBadge = false;
        for (BadgeDataWrapperService.BadgeDataWrapper badge : wrapperResult) {
            if (badge.label == 'Third Basemen') {
                foundMetsBadge = true;
            }
            if (badge.label.toLowerCase().contains('birthday')) {
                foundBirthdayBadge = true;
            }
        }

        System.assert(wrapperResult.size() > 0, 'Did not find any badges for contact');
        System.assert(foundMetsBadge, 'Did not find Mets badge');
        System.assert(foundBirthdayBadge, 'Did not find birthday badge');
        
    }
    
}