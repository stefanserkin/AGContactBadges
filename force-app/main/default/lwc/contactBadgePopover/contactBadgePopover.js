import { LightningElement, api, track } from 'lwc';

export default class ContactBadgePopover extends LightningElement {
    @track badge;
    @track obj;
    @track addField1;
    @track addField2;
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
    get addfield1() {
        return this.addField1;
    }
    set addfield1(value) {
        this.addField1 = value;
    }

    @api
    get addfield2() {
        return this.addField2;
    }
    set addfield2(value) {
        this.addField2 = value;
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