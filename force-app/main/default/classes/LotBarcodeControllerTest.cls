@isTest
private class LotBarcodeControllerTest {

    @isTest
    static void testGetLotByBarcode_Success() {
        Lot__c testLot = new Lot__c(Name = 'Test Lot', Barcode__c = '12345');
        insert testLot;
        
        List<Shipment__c> shipments = new List<Shipment__c>();
        shipments.add(new Shipment__c(Lot__c = testLot.Id, Quantity__c = 10));
        insert shipments;
        
        Retail_Location__c testLocation = new Retail_Location__c(Lot__c = testLot.Id, Name = 'Test Location 1');
        insert testLocation;

        Test.startTest();
        List<Lot__c> result = LotBarcodeController.getLotByBarcode('12345');
        Test.stopTest();
        
        System.assertEquals(1, result.size(), 'The query should return one Lot record.');
        Lot__c retrievedLot = result[0];
        System.assertEquals(1, retrievedLot.Shipments__r.size(), 'The lot should have one related shipment.');
        System.assertEquals(1, retrievedLot.Retail_Locations__r.size(), 'The lot should have one related retail location.');
    }
    
    @isTest
    static void testGetLotByBarcode_Failure() {
        Test.startTest();
        List<Lot__c> result = LotBarcodeController.getLotByBarcode('99999');
        Test.stopTest();
        
        System.assertEquals(0, result.size(), 'The query should return no Lot records.');
    }
}