import { LightningElement, api, wire } from 'lwc';
import getBadgeData from '@salesforce/apex/ContactBadgesController.getBadgeData';

export default class ContactRecordPageBadges extends LightningElement {
    @api recordId;
    error;

    badgeData;
    wiredBadgeDataResult;

    @wire(getBadgeData, { recordId : '$recordId' })
    wiredBadgeData(result) {
        this.wiredBadgeDataResult = result;
        if (result.data) {
            this.badgeData = result.data;
            this.error = undefined;
            console.table(this.badgeData);
        } else if (result.error) {
            this.badgeData = undefined;
            this.error = result.error;
        }
    }

}