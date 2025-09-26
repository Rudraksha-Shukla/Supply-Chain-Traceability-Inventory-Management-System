trigger ShipmentInventoryTrigger on Shipment__c (before insert, before update) {
    Set<Id> lotIds = new Set<Id>();
    for (Shipment__c ship : Trigger.new) {
        if (ship.Lot__c != null) {
            lotIds.add(ship.Lot__c);
        }
    }

    if (!lotIds.isEmpty()) {
        List<Lot__c> lots = [SELECT Id, Current_Inventory__c FROM Lot__c WHERE Id IN :lotIds];
        Map<Id, Lot__c> lotMap = new Map<Id, Lot__c>(lots);

        for (Shipment__c ship : Trigger.new) {
            if (lotMap.containsKey(ship.Lot__c)) {
                Lot__c lot = lotMap.get(ship.Lot__c);
                if (ship.Quantity__c != null) {
                    lot.Current_Inventory__c -= ship.Quantity__c;
                }
            }
        }
        update lots;
    }
}