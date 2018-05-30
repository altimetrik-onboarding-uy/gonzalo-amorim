@isTest
public class myTestClass {
	//TEST TO INSERT CONTACT AND TIMESHEET IN WHOLE getTimesheets()
    @isTest static void testInsertTimesheet() {
        
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id);
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.getTimesheets().size());
        Test.StopTest();
    }
    //TEST TO INSERT CONTACT AND TIMESHEET IN WHOLE getTimesheets() AS 'APPROVED'
    @isTest static void testInsertTimesheetApproved() {
        
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id, Status__c ='APPROVED');
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.getTimesheets().size());
        Test.StopTest();
    }
    
    //TEST TO INSERT CONTACT AND TIMESHEET IN WHOLE getTimesheets() AS 'REJECTED'
    @isTest static void testInsertTimesheetRejected() {
        
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id, Status__c ='REJECTED');
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.getTimesheets().size());
        Test.StopTest();
    }
    
    //TEST TO INSERT CONTACT AND TIMESHEET IN RECENT getRecentTimesheet()
    @isTest static void testGetRecentTimesheet() {
       
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id);
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.getRecentTimesheets().size());
        Test.StopTest();
    }
    
    //TEST TO INSERT CONTACT AND TIMESHEET IN RECENT filterTimesheets()
    @isTest static void testFilterTimesheets() {
       
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id, Status__c='SUBMITTED');
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.filterTimesheets().size());
        Test.StopTest();
    }
    
    //TEST TO INSERT CONTACT AND TIMESHEET IN RECENT filterNotSubmitted()
    @isTest static void testFilterNotSubmitted() {
       
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id);
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.filterNotSubmitted().size());
        Test.StopTest();
    }
    
    //TEST TO INSERT CONTACT AND TIMESHEET IN WHOLE submittedTimesheets()
    @isTest static void testSubmittedTimesheets() {
       
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id, Status__c='SUBMITTED');
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.submittedTimesheets().size());
        Test.StopTest();
    }
    
    //TEST TO INSERT CONTACT AND TIMESHEET IN WHOLE notSubmittedTimesheets()
    @isTest static void testnotSubmittedTimesheets() {
       
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id, Status__c='NOT SUBMITTED');
        insert timeTest;
        
        Test.StartTest();
        system.assertEquals(1, tableListController.notSubmittedTimesheets().size());
        Test.StopTest();
    }
    
    //TEST TO UPDATE SUBMITTED TIMESHEET FROM STATUS 'NOT SUBMITTED' TO 'SUBMITTED' ON myReceivedList()
    @isTest static void testMyReceivedList() {
        
        List<String> myStringList = new List<String>();
        
		Contact testEmp = new Contact(LastName='aTest');
        insert testEmp;
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id, Status__c='NOT SUBMITTED');
        insert timeTest;
        
        Test.StartTest();
        myStringList.add(timeTest.Id);
        tableListController.myReceivedList(myStringList);
        system.assertEquals(1, [SELECT count() FROM Timesheet__c WHERE Status__c='SUBMITTED']);
        Test.StopTest();
    }
}