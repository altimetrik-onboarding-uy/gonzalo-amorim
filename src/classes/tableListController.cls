public with sharing class tableListController {
    
    @AuraEnabled
    public static List<Timesheet__c> getTimesheets() {
        return mapSubmitted([SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c
                FROM Timesheet__c ORDER BY LastModifiedDate]);
    } 
    private static List<Timesheet__c> mapSubmitted(List<Timesheet__c> original){
        for(Timesheet__c ts: original){
            
            if(ts.Status__c.equals('SUBMITTED')){
                ts.Status__c = 'YES';
            }
            else{
                ts.Status__c = 'NO';
            }
                       
        }
        return original;
    }
    
    @AuraEnabled
    public static List<Timesheet__c> getRecentTimesheets(){
        
        List<Timesheet__c> timesheets = new List<Timesheet__c>();
		List<Contact> myRecentList =[SELECT Id,(SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c FROM Timesheets__r ORDER BY LastModifiedDate ASC LIMIT 1) FROM Contact];
        
        for(Contact c : myRecentList){
            if(c.Timesheets__r.size() > 0){
                timesheets.add(c.Timesheets__r);
            }
        }
        return timesheets;
    }
}