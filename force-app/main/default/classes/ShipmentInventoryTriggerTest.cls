@isTest
private class ShipmentInventoryTriggerTest {
    
    @isTest
    static void testDecrementInventory_Insert() {
        // Step 1: Create a Lot record with a starting inventory
        Lot__c testLot = new Lot__c(
            Current_Inventory__c = 100
        );
        insert testLot;

        // Step 2: Create a Shipment record to trigger the logic.
        // The error likely comes from not providing a Lot__c ID.
        Shipment__c testShipment = new Shipment__c(
            Lot__c = testLot.Id,
            Quantity__c = 25
        );
        
        Test.startTest();
        insert testShipment;
        Test.stopTest();
        
        // Step 3: Verify the inventory count was decremented
        Lot__c updatedLot = [SELECT Current_Inventory__c FROM Lot__c WHERE Id = :testLot.Id];
        System.assertEquals(75, updatedLot.Current_Inventory__c, 'Inventory should be decremented by the shipped quantity.');
    }

    @isTest
    static void testDecrementInventory_Update() {
        // Step 1: Create a Lot record
        Lot__c testLot = new Lot__c(Current_Inventory__c = 100);
        insert testLot;

        // Step 2: Create a Shipment record and insert it
        Shipment__c testShipment = new Shipment__c(
            Lot__c = testLot.Id,
            Quantity__c = 25
        );
        insert testShipment;
        
        // Change the quantity to trigger the 'before update' logic
        testShipment.Quantity__c = 50;

        Test.startTest();
        update testShipment;
        Test.stopTest();
        
        // Step 3: Verify the inventory count was updated
        Lot__c updatedLot = [SELECT Current_Inventory__c FROM Lot__c WHERE Id = :testLot.Id];
        System.assertEquals(50, updatedLot.Current_Inventory__c, 'Inventory should be updated on quantity change.');
    }
}