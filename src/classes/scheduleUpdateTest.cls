@isTest
public class scheduleUpdateTest {
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

        static testmethod void testMyScheduledUpdate() 
        {
            Test.startTest();
            String jobId = System.schedule('ScheduleApexClassTest',
                                           CRON_EXP, 
                                           new scheduledUpdate());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                              FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, 
                                ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
            System.assertEquals('2022-03-15 00:00:00', 
                                String.valueOf(ct.NextFireTime));
            Test.stopTest();
        }
    
    static testMethod void testBatch() {
        
        Contact testEmp = new Contact(LastName='aTest');
        insert testEmp; 
        
        Timesheet__c timeTest = new Timesheet__c(Name='Test', Employee__c=testEmp.Id, Status__c='NOT SUBMITTED', 
                                                 Monday__c = 12, Tuesday__c = 12, Wednesday__c = 12, Thursday__c = 12, Friday__c = 12, 
                                                 Hour_Rate__c = 100);
        insert timeTest;
        // startTest/stopTest block to force async processes to run
        Test.startTest(); 
        scheduleUpdateCriteria UC = new scheduleUpdateCriteria();
        DataBase.executeBatch(UC); 
        Test.stopTest(); 

        system.assertEquals(1, [SELECT count() FROM Timesheet__c WHERE Status__c='SUBMITTED']);
   }
}