public without sharing class ContactBadgesHelper {

    public static String getQueryFromDefinition(Contact_Badge_Definition__mdt definition) {
        String query = 'SELECT Id ';
        if (!String.isBlank(definition.Label_Field_Reference__c)) {
            query += ', ' + definition.Label_Field_Reference__c + ' ';
        }
        if (!String.isBlank(definition.Additional_Detail_Fields__c)) {
            query += ', ' + definition.Additional_Detail_Fields__c + ' ';
        }
        query += 'FROM ' + definition.Object_Type__c + ' ';
        query += 'WHERE ' + definition.Relationship_to_Contact_Field__c + ' = :recordId ';
        if (!String.isBlank(definition.Filter_Criteria__c)) {
            query += 'AND (' + definition.Filter_Criteria__c + ')';
        }
        return query;
    }

    public static String getBadgeLabel(Contact_Badge_Definition__mdt definition, SObject obj) {
        String badgeLabel = '';
        if (definition.Badge_Label_Type__c == 'Value') {
            badgeLabel = definition.Label_Value__c;
        } else if (definition.Badge_Label_Type__c == 'Field Reference') {
            Map<String,Object> mapObjFields = obj.getPopulatedFieldsAsMap();
            badgeLabel = String.valueOf(mapObjFields.get(definition.Label_Field_Reference__c));
        }
        return badgeLabel;
    }

    public static String getBadgeColorStyle(Contact_Badge_Definition__mdt definition) {
        String hexColor = definition.Background_Color__c != null ? '#' + definition.Background_Color__c : '#D3D3D3';
        String badgeColorStyle = '--sds-c-badge-color-background:' + hexColor + ';';
        return badgeColorStyle;
    }

    public static String getBadgeLabelStyle(Contact_Badge_Definition__mdt definition) {
        String labelHexColor = definition.Label_Color__c != null ? '#' + definition.Label_Color__c : '#000000';
        String badgeLabelStyle = '--sds-c-badge-text-color:' + labelHexColor + ';';
        return badgeLabelStyle;
    }

    public static String getBadgeIconName(Contact_Badge_Definition__mdt definition) {
        String iconName = !String.isBlank(definition.Icon_Name__c) ? definition.Icon_Name__c : 'utility:alert';
        return iconName;
    }

    public static List<Contact_Badge_Definition__mdt> sortContactBadgeDefinitions(
        List<Contact_Badge_Definition__mdt> lstDefinitions
    ) {
        List<Contact_Badge_Definition__mdt> lstSortedDefinitions = new List<Contact_Badge_Definition__mdt>();
        ContactBadgeDefinitionWrapper[] lstCBDWrapper = new List<ContactBadgeDefinitionWrapper>();
        for (Contact_Badge_Definition__mdt definition : lstDefinitions) {
            lstCBDWrapper.add( new ContactBadgeDefinitionWrapper(definition) );
        }
        lstCBDWrapper.sort();
        for (ContactBadgeDefinitionWrapper cbdWrapper : lstCBDWrapper) {
            lstSortedDefinitions.add( cbdWrapper.cbd );
        }
        return lstSortedDefinitions;
    }
    
}
