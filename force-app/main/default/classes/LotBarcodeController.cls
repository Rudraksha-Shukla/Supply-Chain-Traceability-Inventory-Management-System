public class LotBarcodeController {

    /**
     * @description Retrieves a Lot record and its associated shipments and retail locations.
     * @param barcode The barcode string to search for.
     * @return A list of Lot records with related lists populated.
     */
    @AuraEnabled(cacheable=true)
    public static List<Lot__c> getLotByBarcode(String barcode) {
        // Query for Lot__c records and their related lists using a SOQL subquery.
        // The query filters by the barcode field on the Lot__c object.
        return [
            SELECT Id, Name, Barcode__c,
                   (SELECT Id, Name, Quantity__c FROM Shipments__r),
                   (SELECT Id, Name, Address__c FROM Retail_Locations__r)
            FROM Lot__c
            WHERE Barcode__c = :barcode
            LIMIT 1
        ];
    }
}