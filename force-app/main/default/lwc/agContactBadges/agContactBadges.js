import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getActiveMembershipNames from '@salesforce/apex/ContactBadgesController.getActiveMembershipNames';
import getBadgeData from '@salesforce/apex/ContactBadgesController.getBadgeData';

import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import STAFF_MEMBER_FIELD from '@salesforce/schema/Contact.Staff_Member__c';
import OUTSTANDING_BALANCE_FIELD from '@salesforce/schema/Contact.Has_Outstanding_Balance__c';

export default class AgContactBadges extends LightningElement {
    @api recordId;
    hasRendered = false;
    error;

    firstName = '';
    lastName = '';
    cardTitle = `Relationship to Asphalt Green`;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: [FIRST_NAME_FIELD, LAST_NAME_FIELD, STAFF_MEMBER_FIELD, OUTSTANDING_BALANCE_FIELD]
    }) wireuser({
        error,
        data
    }) {
        if (error) {
            this.error = error; 
        } else if (data) {
            this.firstName = data.fields.FirstName.value;
            this.lastName = data.fields.LastName.value;
            this.isStaffMember = data.fields.Staff_Member__c.value;
            this.hasOutstandingBalance = data.fields.Has_Outstanding_Balance__c.value;
        }
    }

    // Badges displayed
    membershipNames = [];
    registrationNames = ['stuff'];
    affiliationNames = ['stuff'];
    donorLevelNames = ['stuff'];
    isStaffMember = false;
    hasOutstandingBalance = false;

    wiredMembershipNamesResult;

    @wire(getActiveMembershipNames, { recordId : '$recordId' })
    wiredMembershipNames(result) {
        this.wiredMembershipNamesResult = result;
        if (result.data) {
            this.membershipNames = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.membershipNames = undefined;
            this.error = result.error;
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

    renderedCallback() {
        if (!this.hasRendered && this.hasOutstandingBalance) {
            alert('ALERT: ' + this.firstName + ' ' + this.lastName + ' has an outstanding balance on their account.'); 
            this.hasRendered = true;
        }
    }

}