@isTest
public class myTestClass {
	
    @isTest static void testInsertTimesheet() {
        
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id);
        insert timeTest;
        
        system.assertEquals(1, tableListController.getTimesheets().size());
    }
    
    @isTest static void testGetRecentTimesheet() {
       
        Contact testRec = new Contact(LastName='aTest');
        insert testRec;
        
        Timesheet__c timeRec = new Timesheet__c(Name='Test', Employee__c=testRec.Id);
        insert timeRec;
        
        system.assertEquals(1, tableListController.getRecentTimesheets().size());
    }
}