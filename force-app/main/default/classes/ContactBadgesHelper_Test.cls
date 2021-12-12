@isTest
private class ContactBadgesHelper_Test {

    private static Id hhRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('HH_Account').getRecordTypeId();
    private static Contact_Badge_Definition__mdt birthdayBadgeDefinition = Contact_Badge_Definition__mdt.getInstance('Birthday_Badge');
    
    @isTest
    static void testGetBadgeLabel() {

        Account acc = new Account(Name='Wright Household', RecordTypeId=hhRecTypeId);
        insert acc;

        Contact ct = new Contact(AccountId=acc.Id, FirstName='David', LastName='Wright', Email='capn@mets.com', Birthdate=Date.today(), Title='Third Basemen');
        insert ct;
        
        Test.startTest();
        String badgeLabel = ContactBadgesHelper.getBadgeLabel(birthdayBadgeDefinition, ct);
        Test.stopTest();

        String expectedLabel = 'It\'s my birthday!';

        System.assertEquals(expectedLabel, badgeLabel, 'Unexpected label for birthday badge');
        
    }

    @isTest
    static void testGetBadgeColorStyle() {
        Test.startTest();
        String badgeColorStyle = ContactBadgesHelper.getBadgeColorStyle(birthdayBadgeDefinition);
        Test.stopTest();
        String expectedString = '--sds-c-badge-color-background:#D3D3D3;';
        System.assertEquals(expectedString, badgeColorStyle, 'Unexpected string for badge color style');
    }

    @isTest
    static void testGetBadgeLabelStyle() {
        Test.startTest();
        String badgeLabelStyle = ContactBadgesHelper.getBadgeLabelStyle(birthdayBadgeDefinition);
        Test.stopTest();
        String expectedString = '--sds-c-badge-text-color:#000000;';
        System.assertEquals(expectedString, badgeLabelStyle, 'Unexpected string for badge label style');
    }

    @isTest
    static void testGetBadgeIconName() {
        Test.startTest();
        String badgeIconName = ContactBadgesHelper.getBadgeIconName(birthdayBadgeDefinition);
        Test.stopTest();
        String expectedString = birthdayBadgeDefinition.Icon_Name__c;
        System.assertEquals(expectedString, badgeIconName, 'Unexpected string for icon name');
    }

}
