({
    createTimesheet: function(component, timesheet) {
        var theTimesheets = component.get("v.timesheet");
 
        // Copy the timesheet to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        var newTimesheet = JSON.parse(JSON.stringify(timesheet));
 		console.log("Timesheets before 'create': " + JSON.stringify(theTimesheets));
        theTimesheets.push(newTimesheet);
        component.set("v.timesheet", theTimesheets);
        console.log("Timesheets after 'create': " + JSON.stringify(theTimesheets));
    }
})