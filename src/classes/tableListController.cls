public with sharing class tableListController {
    
    //GRAB ALL TIMESHEETS AND SET Submitted__c AS 'YES/NO'
    @AuraEnabled
    public static List<Timesheet__c> getTimesheets() {
        return mapSubmitted ([SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c, Submitted__c
                FROM Timesheet__c ORDER BY LastModifiedDate]);
    }
    private static List<Timesheet__c> mapSubmitted(List<Timesheet__c> original){
        for(Timesheet__c ts: original){
            
            if(ts.Status__c.equals('SUBMITTED')){
                ts.Submitted__c = 'YES';
            } 
            else if (ts.Status__c.equals('NOT SUBMITTED')){
                ts.Submitted__c = 'NO';
            } else if (ts.Status__c.equals('APPROVED')){
                ts.Submitted__c = 'YES';
            } else if (ts.Status__c.equals('REJECTED')){
                ts.Submitted__c = 'YES';
            }         
        }
        return original;
    }
    
    //GRAB ALL RECENT TIMESHEETS FROM EACH EMPLOYEE
    @AuraEnabled
    public static List<Timesheet__c> getRecentTimesheets(){
        
        List<Timesheet__c> timesheets = new List<Timesheet__c>();
		List<Contact> myRecentList = [SELECT Id,(SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c, Submitted__c FROM Timesheets__r ORDER BY LastModifiedDate DESC LIMIT 1) FROM Contact];
        
        for(Contact c : myRecentList){
            if(c.Timesheets__r.size() > 0){
                timesheets.add(c.Timesheets__r);
            }
        }
        return mapSubmitted(timesheets);
    }
    
    //GRAB ALL RECENT TIMESHEETS FILTERED AS 'SUBMITTED'
    @AuraEnabled
    public static List<Timesheet__c> filterTimesheets() {
        List<Timesheet__c> timesheets = new List<Timesheet__c>();
        List<Contact> myFilterList =[SELECT Id,(SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c, Submitted__c FROM Timesheets__r WHERE Status__c ='SUBMITTED' ORDER BY LastModifiedDate ASC LIMIT 1) FROM Contact];
        
		 for(Contact c : myFilterList){
            if(c.Timesheets__r.size() > 0){
                timesheets.add(c.Timesheets__r);
            }
        }
        return mapSubmitted(timesheets);        
    }
    
    //GRAB ALL RECENT TIMESHEETS FILTERED AS 'NOT SUBMITTED'
    @AuraEnabled
    public static List<Timesheet__c> filterNotSubmitted() {
        List<Timesheet__c> timesheets = new List<Timesheet__c>();
        List<Contact> myFilterList =[SELECT Id,(SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c, Submitted__c FROM Timesheets__r WHERE Status__c ='NOT SUBMITTED' ORDER BY LastModifiedDate ASC LIMIT 1) FROM Contact];
        
		 for(Contact c : myFilterList){
            if(c.Timesheets__r.size() > 0){
                timesheets.add(c.Timesheets__r);
            }
        }
        return mapSubmitted(timesheets);        
    }
    
    //GRAB ALL TIMESHEETS FILTERED AS 'SUBMITTED'
    @AuraEnabled
    public static List<Timesheet__c> submittedTimesheets(){
        
		return mapSubmitted ([SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c, Submitted__c
                FROM Timesheet__c WHERE Status__c = 'SUBMITTED' ORDER BY LastModifiedDate]);
    }
    
    //GRAB ALL TIMESHEETS FILTERED AS 'NOT SUBMITTED'
    @AuraEnabled
    public static List<Timesheet__c> notSubmittedTimesheets(){
        
        return mapSubmitted ([SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, 
                       Gross_Pay__c, Taxes__c, Type__c, Status__c, Submitted__c
                FROM Timesheet__c WHERE Status__c = 'NOT SUBMITTED' ORDER BY LastModifiedDate]);
    }
    
    //FILTER MY RECEIVED LIST AND SET STATUS AS 'SUBMITTED' (Submit Timesheets BUTTON BACKEND-ACTION)
    @AuraEnabled
    public static void myReceivedList(List<String> myList){

        List<Timesheet__c> myListToUpdate = new List<Timesheet__c>();
        myListToUpdate = updateMap([SELECT Id, Employee__r.Name, Employee__r.Birthdate, Start_Date__c, End_Date__c, Sum_Of_Hours__c, Gross_Pay__c, Taxes__c, Type__c, Status__c, Submitted__c
                FROM Timesheet__c WHERE Id IN :myList AND (Status__c = 'NOT SUBMITTED' OR Status__c = 'APPROVED' OR Status__c = 'REJECTED') ORDER BY LastModifiedDate]);
        update myListToUpdate;
    }
    
    private static List<Timesheet__c> updateMap(List<Timesheet__c> original){
        for(Timesheet__c ts: original){      
                ts.Status__c = 'SUBMITTED';
        }
        return original;
    }
}