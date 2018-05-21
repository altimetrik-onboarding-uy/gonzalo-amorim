({
    clickCreate: function(component, event, helper) {
        var validTimesheet = component.find('timesheetForm').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validTimesheet){
            // Create the new timesheet
            var newTimesheet= component.get("v.newTimesheet");
            console.log("Create timesheet: " + JSON.stringify(newTimesheet));
            helper.createTimesheet(component, newTimesheet);
        }
    }
})