@isTest
private class BadgeDataWrapperService_Test {

    private static Id hhRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('HH_Account').getRecordTypeId();
    private static Id donationRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId();
    private static List<Contact_Badge_Definition__mdt> lstDefinitions = Contact_Badge_Definition__mdt.getAll().values();


    @isTest
    static void testBadgeWithDynamicLabel() {
        BadgeDataWrapperService.isTestScenario = true;

        Account acc = new Account(Name='Wright Household', RecordTypeId=hhRecTypeId);
        insert acc;

        Contact ct = new Contact(AccountId=acc.Id, FirstName='David', LastName='Wright', Email='capn@mets.com', Birthdate=Date.today(), Title='Third Basemen');
        insert ct;

        List<BadgeDataWrapperService.BadgeDataWrapper> wrapperResult = new List<BadgeDataWrapperService.BadgeDataWrapper>();
        
        Test.startTest();
        wrapperResult = BadgeDataWrapperService.getBadgeDataForContact(ct.Id, acc.Id);
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
        
        System.assert(wrapperResult.size() > 0, 'Did not find matching badge for contact');
        System.assert(foundMetsBadge, 'Did not find Mets badge');
        System.assert(foundBirthdayBadge, 'Did not find birthday badge');
        
    }

    @isTest
    static void testDuplicateBadgeLabels() {
        BadgeDataWrapperService.isTestScenario = true;

        Account acc = new Account(Name='Wright Household', RecordTypeId=hhRecTypeId);
        insert acc;

        Contact ct = new Contact(AccountId=acc.Id, FirstName='David', LastName='Wright', Email='capn@mets.com', Birthdate=Date.today(), Title='Third Basemen');
        insert ct;

        List<Opportunity> lstOppys = new List<Opportunity>();
        Opportunity oppy  = new Opportunity(Name='Test Oppy', ContactId=ct.Id, AccountId=acc.Id, Amount=100000, StageName='Closed Won', CloseDate=Date.today().addDays(-1), RecordTypeId=donationRecordTypeId);
        Opportunity oppy2 = new Opportunity(Name='Test Oppy 2', ContactId=ct.Id, AccountId=acc.Id, Amount=100001, StageName='Closed Won', CloseDate=Date.today().addDays(-2), RecordTypeId=donationRecordTypeId);
        lstOppys.add(oppy);
        lstOppys.add(oppy2);
        insert lstOppys;

        List<BadgeDataWrapperService.BadgeDataWrapper> wrapperResult = new List<BadgeDataWrapperService.BadgeDataWrapper>();
        
        Test.startTest();
        wrapperResult = BadgeDataWrapperService.getBadgeDataForContact(ct.Id, acc.Id);
        Test.stopTest();

        System.assert(wrapperResult.size() > 0, 'Did not find matching badge for contact');

        for (BadgeDataWrapperService.BadgeDataWrapper badge : wrapperResult) {
            if (badge.label == 'Major gift in last 30 days') {
                System.assertEquals(oppy.Id, badge.id, 'Received badge for incorrect opportunity');
            }
        }
                
    }

    
}
