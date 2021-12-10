import { LightningElement, api, track } from 'lwc';

export default class ContactBadgePopover extends LightningElement {
    @track badge;
    @track obj;
    @track top = 50;
    @track left = 50;

    @api
    get mybadge() {
        return this.badge;
    }
    set mybadge(value) {
        this.badge = value;
    }

    @api
    get myobj() {
        return this.obj;
    }
    set myobj(value) {
        this.obj = value;
    }

    @api
    get topmargin() {
        return this.top;
    }
    set topmargin(value) {
        this.top = value;
    }

    @api
    get leftmargin() {
        return this.left;
    }
    set leftmargin(value) {
        this.left = value;
    }

    get boxClass() { 
        return `background-color:white; top:${this.top - 280}px; left:${this.left}px`;
    }

}