import { LightningElement, api, track } from 'lwc';

export default class ContactBadgePopover extends LightningElement {
    @track badge;
    @track obj;
    @api fieldset = [];
    @track top = 50;
    @track left = 50;

    @api
    get selectedbadge() {
        return this.badge;
    }
    set selectedbadge(value) {
        this.badge = value;
    }

    @api
    get object() {
        return this.obj;
    }
    set object(value) {
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