public with sharing class ContactBadgesController {

    @AuraEnabled(cacheable=true)
    public static List<BadgeDataWrapper> getBadgeData(String recordId) {

        List<Contact_Badge_Definition__mdt> cbdList = Contact_Badge_Definition__mdt.getAll().values();
        List<BadgeDataWrapper> lstBadgeData = new List<BadgeDataWrapper>();

        for (Contact_Badge_Definition__mdt cbd : cbdList) {
            if (!cbd.Active__c) {
                continue;
            }

            // Get results of query in Contact Badge Definition
            String query = cbd.Query__c;
            List<SObject> queryResults = Database.query(query);

            // Load results into 
            for (SObject obj : queryResults) {
                BadgeDataWrapper bdw = new BadgeDataWrapper();
                bdw.id = obj.Id;
                // Set label based on label type
                if (cbd.Badge_Label_Type__c == 'Value') {
                    bdw.label = cbd.Label_Value__c;
                } else if (cbd.Badge_Label_Type__c == 'Field Reference') {
                    Map<String,Object> mapObjFields = obj.getPopulatedFieldsAsMap();
                    bdw.label = String.valueOf(mapObjFields.get(cbd.Label_Field_Reference__c));
                }
                // Set hex color
                bdw.hexColor = cbd.Background_Color__c != null ? '#' + cbd.Background_Color__c : '#D3D3D3';
                lstBadgeData.add(bdw);
            }
        }

        return lstBadgeData;
        
    }

    private class BadgeDataWrapper {
        @AuraEnabled
        public Id id {get;set;}

        @AuraEnabled
        public String label {get;set;}

        @AuraEnabled
        public String hexColor {get;set;}

        @AuraEnabled
        public List<String> fieldSet {get;set;}
    }

}