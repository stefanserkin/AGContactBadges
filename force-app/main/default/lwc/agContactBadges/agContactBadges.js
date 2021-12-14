import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getBadgeData from '@salesforce/apex/ContactBadgesController.getBadgeData';

import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';

export default class AgContactBadges extends LightningElement {
    @api recordId;
    error;

    firstName = '';
    lastName = '';
    cardTitle = `Relationship to Asphalt Green`;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: [FIRST_NAME_FIELD, LAST_NAME_FIELD]
    }) wireuser({
        error,
        data
    }) {
        if (error) {
            this.error = error; 
        } else if (data) {
            this.firstName = data.fields.FirstName.value;
            this.lastName = data.fields.LastName.value;
        }
    }

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