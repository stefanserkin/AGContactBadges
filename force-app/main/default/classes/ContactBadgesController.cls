public with sharing class ContactBadgesController {
    
    @AuraEnabled(cacheable=true)
    public static List<String> getActiveMembershipNames(String contactId){
        List<String> lstMembershipNames = new List<String>();
        List<TREX1__Membership__c> lstMemberships = [
            SELECT Id, Name, TREX1__memb_Type__r.Name
              FROM TREX1__Membership__c 
             WHERE TREX1__Contact__c = :contactId 
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

}
