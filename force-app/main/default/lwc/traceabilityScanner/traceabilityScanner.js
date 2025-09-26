import { LightningElement, track } from 'lwc';
    import getLotByBarcode from '@salesforce/apex/LotBarcodeController.getLotByBarcode';

    export default class TraceabilityScanner extends LightningElement {
        @track barcode = '';
        @track lotRecord;
        @track error;

        handleBarcodeChange(event) {
            this.barcode = event.target.value;
        }

        async handleScan() {
            this.lotRecord = null;
            this.error = null;

            if (!this.barcode) {
                this.error = 'Please enter a barcode.';
                return;
            }

            try {
                const result = await getLotByBarcode({ barcode: this.barcode });
                if (result && result.length > 0) {
                    this.lotRecord = result[0];
                } else {
                    this.error = 'No product found with this barcode.';
                }
            } catch (error) {
                this.error = 'An unexpected error occurred: ' + error.body.message;
                console.error('Error:', error);
            }
        }
   }