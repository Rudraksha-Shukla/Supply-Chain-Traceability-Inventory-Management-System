@isTest
private class InventoryReorderSchedulerTest {
    
    @isTest
    static void testSchedulerExecution() {
        List<sObject> testRecords = new List<sObject>();
        testRecords.add(new Product__c(Current_Inventory__c = 5, Name = 'Low Stock Product'));
        testRecords.add(new Retail_Location__c(Current_Inventory__c = 3, Name = 'Low Stock Location'));
        insert testRecords;
        
        Test.startTest();
        String jobId = System.schedule('TestJob', '0 0 0 1 1 ? 2050', new InventoryReorderScheduler());
        Test.stopTest();
        
        System.assertNotEquals(null, jobId, 'The scheduled job ID should not be null.');
    }
}