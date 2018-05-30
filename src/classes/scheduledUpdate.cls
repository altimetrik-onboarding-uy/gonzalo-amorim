global class scheduledUpdate implements Schedulable{
    
	global void execute(SchedulableContext sc) {		
		scheduleUpdateCriteria UC = new scheduleUpdateCriteria();
		database.executeBatch(UC);
	}
}