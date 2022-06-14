public with sharing class ContactBadgesPlatformCacheUtilities {

    private static final String CACHE_KEY_PREFIX = 'cb';
    private static final String CACHE_PARTITION_NAME = 'local.ContactBadges';
    
    /****************************************************
     * Returns true if this is the running user's first visit to this
     *     Contact page in the current session and caches the current
     *     visit. Returns false if a visit is found in the session cache
     * @param String Contact Id (recordId)
     ****************************************************/

    public static Boolean verifyFirstSessionVisit(String recordId) {
        Boolean isFirstVisit;
        // Create cache key out of user and contact ids
        String userId = UserInfo.getUserId();
        String cacheContactKey = CACHE_KEY_PREFIX + userId + recordId;
        // Create instance of session partition
        Cache.SessionPartition part = Cache.Session.getPartition(CACHE_PARTITION_NAME);
        if (part.contains(cacheContactKey)) {
            isFirstVisit = false;
        } else {
            part.put(cacheContactKey, Datetime.now());
            isFirstVisit = true;
        }
        return isFirstVisit;
    }


}
