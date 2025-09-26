public class InventoryReorderScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {
        // ... (existing logic for scheduling) ...
    }
    
    @AuraEnabled(cacheable=true)
    public static List<sObject> getLowInventoryItems() {
        List<sObject> lowInventoryItems = new List<sObject>();
        
        // Corrected Query for Products
        lowInventoryItems.addAll([
            SELECT Id, Name, Current_Inventory__c
            FROM Product__c
            WHERE Current_Inventory__c < 10
        ]);

        // Corrected Query for Retail Locations
        lowInventoryItems.addAll([
            SELECT Id, Name, Current_Inventory__c
            FROM Retail_Location__c
            WHERE Current_Inventory__c < 5
        ]);
        
        return lowInventoryItems;
    }
}