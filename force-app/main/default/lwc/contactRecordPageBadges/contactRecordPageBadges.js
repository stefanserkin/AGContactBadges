import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getBadgeData from '@salesforce/apex/ContactBadgesController.getBadgeData';

export default class ContactRecordPageBadges extends NavigationMixin(LightningElement) {
    @api recordId;
    error;

    @track badgeData = [];
    @track wiredBadgeDataResult;
    @track badgeObj;
    @track badge;
    @track objType;
    @track fieldSetArray = [];
    @track selectedBadgeId;
    @track selectedObjName;

    @wire(getBadgeData, { recordId : '$recordId' })
    wiredBadgeData(result) {
        this.wiredBadgeDataResult = result;
        if (result.data) {
            this.badgeData = result.data;
            this.error = undefined;
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
        this.fieldSetArray = event.currentTarget.dataset.fieldset.split(',');
		this.left = event.clientX;
		this.top = event.clientY;
	}

	hideData() {
		this.badge = "";
        this.objType = "";
        this.fieldSetArray = [];
	}

    handleBadgeClick(event) {
        const selectedBadgeData = event.currentTarget.dataset;
        this.selectedBadgeId = selectedBadgeData.badgeid;
        this.selectedObjName = selectedBadgeData.objtype;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.selectedBadgeId,
                objectApiName: this.selectedObjName,
                actionName: 'view'
            }
        });
    }

}