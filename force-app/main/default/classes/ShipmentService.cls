@RestResource(urlMapping='/ShipmentService/*')
global class ShipmentService {

    @HttpPost
    global static void createShipment() {
        // Get the incoming JSON payload from the request
        RestRequest request = RestContext.request;
        String requestBody = request.requestBody.toString();

        try {
            // Deserialize the JSON string into a map of key-value pairs
            Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

            // Extract data from the payload
            String lotBarcode = (String)payload.get('lotBarcode');
            Integer quantity = (Integer)payload.get('quantity');

            // Find the Lot record based on the barcode
            Lot__c relatedLot = [SELECT Id, Current_Inventory__c FROM Lot__c WHERE Barcode__c = :lotBarcode LIMIT 1];

            // Create the new Shipment record
            Shipment__c newShipment = new Shipment__c(
                Lot__c = relatedLot.Id,
                Quantity__c = quantity
            );

            // Insert the new Shipment record, which will trigger the Apex trigger
            insert newShipment;

        } catch (Exception e) {
            // Handle any errors that may occur
            RestContext.response.statusCode = 400;
            RestContext.response.responseBody = Blob.valueOf('Error: ' + e.getMessage());
        }
    }
}