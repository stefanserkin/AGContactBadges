public without sharing class ContactBadgesHelper {

    public static String getQueryFromDefinition(Contact_Badge_Definition__mdt definition) {
        
        String query = 'SELECT Id ';

        if (!String.isBlank(definition.Label_Field_Reference__c)) {
            query += ', ' + definition.Label_Field_Reference__c + ' ';
        }
        if (!String.isBlank(definition.Additional_Detail_Fields__c)) {
            query += ', ' + definition.Additional_Detail_Fields__c + ' ';
        }
        query += 'FROM ' + '';
        

        return query;

    }
    
}
