@isTest
private class ShipmentServiceTest {

    @isTest
    static void testCreateShipment() {
        // Step 1: Create test data
        Lot__c testLot = new Lot__c(Barcode__c = 'BARCODE123', Current_Inventory__c = 100);
        insert testLot;

        // Step 2: Simulate a REST request with a JSON payload
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/ShipmentService/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf('{"lotBarcode": "BARCODE123", "quantity": 10}');

        RestContext.request = request;

        Test.startTest();
        ShipmentService.createShipment();
        Test.stopTest();

        // Step 3: Verify the new record was created and the inventory was decremented
        List<Shipment__c> shipments = [SELECT Id, Lot__c, Quantity__c FROM Shipment__c WHERE Lot__c = :testLot.Id];
        Lot__c updatedLot = [SELECT Current_Inventory__c FROM Lot__c WHERE Id = :testLot.Id];

        System.assertEquals(1, shipments.size(), 'A new shipment record should have been created.');
        System.assertEquals(90, updatedLot.Current_Inventory__c, 'Inventory should be decremented.');
    }
}