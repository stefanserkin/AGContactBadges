import { LightningElement, api, wire, track } from 'lwc';
import getBadgeData from '@salesforce/apex/ContactBadgesController.getBadgeData';

export default class ContactRecordPageBadges extends LightningElement {
    @api recordId;
    error;

    @track badgeData = [];
    @track wiredBadgeDataResult;
    @track badge;
    @track objType;

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

    get displayBadges() {
        return this.badgeData.length > 0 ? true : false;
    }

    showData(event) {
		this.badge = event.currentTarget.dataset.badgeid;
        this.objType = event.currentTarget.dataset.objtype;
		this.left = event.clientX;
		this.top = event.clientY;
        console.log(this.badge);
        console.log(this.objType);
	}
	hideData() {
		this.badge = "";
        console.log('Oh! No more badge');
	}

}