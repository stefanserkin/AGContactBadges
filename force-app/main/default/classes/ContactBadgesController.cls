public with sharing class ContactBadgesController {
    
    @AuraEnabled(cacheable=true)
    public static List<String> getActiveMembershipNames(String recordId) {
        List<String> lstMembershipNames = new List<String>();
        List<TREX1__Membership__c> lstMemberships = [
            SELECT Id, Name, TREX1__memb_Type__r.Name
              FROM TREX1__Membership__c 
             WHERE TREX1__Contact__c = :recordId 
               AND TREX1__Status__c IN ('Active', 'Pending Withdrawal', 'Pending Transfer')
              WITH SECURITY_ENFORCED
             LIMIT 150
        ];
        for (TREX1__Membership__c mem : lstMemberships) {
            if (mem.TREX1__memb_Type__r.Name != null) {
                lstMembershipNames.add(mem.TREX1__memb_Type__r.Name);
            }
        }
        return lstMembershipNames;
    }


    @AuraEnabled(cacheable=true)
    public static List<SObject> getBadgeData(String recordId) {
        String objName = 'TREX1__Registration__c';
        List<String> objFields = new List<String>();
        objFields.add('TREX1__Course_Session_Name__c');
        objFields.add('TREX1__Registration_Status__c');
        String filterCriteria = 'TREX1__Registration_Status__c LIKE \'Active\'';

        String query = 'SELECT Id';
        for (String objField : objFields) {
            query += ', ' + objField;
        }
        query += ' FROM ' + objName;
        query += ' WHERE ' + filterCriteria;

        List<SObject> lstSObjects = Database.query(query);
        return lstSObjects;
        
    }

}
