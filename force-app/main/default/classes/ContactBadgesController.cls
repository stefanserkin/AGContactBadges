public with sharing class ContactBadgesController {

    @AuraEnabled(cacheable=true)
    public static List<BadgeDataWrapper> getBadgeData(String recordId) {
        // Get all Contact Badge Definitions
        List<Contact_Badge_Definition__mdt> lstUnsortedDefinitions = Contact_Badge_Definition__mdt.getAll().values();
        // Sort list by sort order
        List<Contact_Badge_Definition__mdt> lstDefinitions = ContactBadgesHelper.sortContactBadgeDefinitions(lstUnsortedDefinitions);
        // Create empty list of wrappers to return
        List<BadgeDataWrapper> lstBadgeData = new List<BadgeDataWrapper>();

        for (Contact_Badge_Definition__mdt definition : lstDefinitions) {
            if (!definition.Active__c) {
                continue;
            }
            // Query for related records
            String query = ContactBadgesHelper.getQueryFromDefinition(definition);
            List<SObject> queryResults = Database.query(query);
            // Create wrapper from mdt details and add to list
            for (SObject obj : queryResults) {
                BadgeDataWrapper badge = new BadgeDataWrapper();
                badge.id              = obj.Id;
                badge.objType         = definition.Object_Type__c;
                badge.label           = ContactBadgesHelper.getBadgeLabel(definition, obj);
                badge.hexColor        = ContactBadgesHelper.getBadgeColor(definition);
                badge.colorStyle      = ContactBadgesHelper.getBadgeColorStyle(definition);
                badge.labelStyle      = ContactBadgesHelper.getBadgeLabelStyle(definition);
                badge.iconName        = ContactBadgesHelper.getBadgeIconName(definition);
                // List<String> fieldSet = ContactBadgesHelper.constructFieldSet(definition);
                badge.fieldSet        = definition.Additional_Detail_Fields__c;
                lstBadgeData.add(badge);
            }
        }
        return lstBadgeData;
    }

    private class BadgeDataWrapper {
        @AuraEnabled
        public Id id {get;set;}
        @AuraEnabled
        public String objType {get;set;}
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public String hexColor {get;set;}
        @AuraEnabled
        public String colorStyle {get;set;}
        @AuraEnabled
        public String labelStyle {get;set;}
        @AuraEnabled
        public String iconName {get;set;}
        @AuraEnabled
        public String addField1 {get;set;}
        @AuraEnabled
        public String addField2 {get;set;}
        @AuraEnabled
        public String fieldSet {get;set;}
    }

}
