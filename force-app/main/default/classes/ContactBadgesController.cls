public with sharing class ContactBadgesController {

    @AuraEnabled(cacheable=true)
    public static List<BadgeDataWrapperService.BadgeDataWrapper> getBadgeData(String recordId, String accountId) {
        List<BadgeDataWrapperService.BadgeDataWrapper> wrapperResult = BadgeDataWrapperService.getBadgeDataForContact(recordId, accountId);
        return wrapperResult;
    }

}
