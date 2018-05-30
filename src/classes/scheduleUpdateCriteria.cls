global class scheduleUpdateCriteria implements Database.Batchable<sObject>{
    // Schedule Update of Timesheets records everyday at midnight with Criteria: Status__c = 'NOT SUBMITTED' AND Gross_Pay__c > 5000'
   	
   	global Database.QueryLocator start(Database.BatchableContext BC){
		string query = 'SELECT Id, Status__c FROM Timesheet__c WHERE Status__c = \'NOT SUBMITTED\' AND Gross_Pay__c > 5000';
		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC,List<sObject> scope) {
        List<Timesheet__c> updateObjs = new List<Timesheet__c>();
        for(sobject s : scope) {
        	    Timesheet__c obj = (Timesheet__c) s;
          	    obj.Status__c = 'SUBMITTED';
          	    updateObjs.add(obj);
      	      }  
        update updateObjs;
   	}
   	
   	global void finish(Database.BatchableContext BC) {
    	      system.debug('Batch Job to update Timesheets is complete!');
   	}
}