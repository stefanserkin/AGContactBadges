import { LightningElement, api, wire, track } from 'lwc';
import getBadgeData from '@salesforce/apex/ContactBadgesController.getBadgeData';

export default class ContactRecordPageBadges extends LightningElement {
    @api recordId;
    error;

    @track badgeData = [];
    @track wiredBadgeDataResult;
    @track badge;
    @track objType;
    @track addField1;
    @track addField2;

    @wire(getBadgeData, { recordId : '$recordId' })
    wiredBadgeData(result) {
        this.wiredBadgeDataResult = result;
        if (result.data) {
            this.badgeData = result.data;
            this.error = undefined;
            console.table(this.badgeData);
            console.log(this.badgeData);
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
        this.addField1 = event.currentTarget.dataset.addfield1;
        this.addField2 = event.currentTarget.dataset.addfield2;
		this.left = event.clientX;
		this.top = event.clientY;
        console.log(this.addField1);
        console.log(this.addField2);
	}
	hideData() {
		this.badge = "";
	}

}