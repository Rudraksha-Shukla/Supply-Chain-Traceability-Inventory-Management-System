import { LightningElement, track, wire } from 'lwc';
    import getLowInventoryItems from '@salesforce/apex/InventoryReorderScheduler.getLowInventoryItems';

    export default class InventoryDashboard extends LightningElement {
        @track lowInventoryItems = [];
        @track error;
        @track hasRecords = false;

        @wire(getLowInventoryItems)
        wiredItems({ error, data }) {
            if (data) {
                this.lowInventoryItems = data;
                this.hasRecords = data.length > 0;
                this.error = undefined;
            } else if (error) {
                this.error = error;
                this.lowInventoryItems = undefined;
                this.hasRecords = false;
            }
        }
    }