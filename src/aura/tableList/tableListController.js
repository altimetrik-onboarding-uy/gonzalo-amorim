({// LOAD MAIN TABLE
    init: function (cmp, event, helper) {
        var action = cmp.get("c.getTimesheets");
        action.setCallback(this, function(response) {
            // console.log(JSON.stringify(response.getReturnValue()));
            var state = response.getState();
            if (state === "SUCCESS") {
                var a=response.getReturnValue();
                //console.log(JSON.stringify(a))
                cmp.set("v.mydata", a);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
         cmp.set('v.mycolumns', [
             	{label: 'Timesheet detail', fieldName: 'Id', type: 'text'},
                {label: 'Employee name', fieldName: 'Employee__r.Name', type: 'text'},
                {label: 'Start Date', fieldName: 'Start_Date__c', type: 'Date'},
                {label: 'End Date', fieldName: 'End_Date__c', type: 'Date'},
                {label: 'Total Hours', fieldName: 'Sum_Of_Hours__c', type: 'number'},
        		{label: 'Gross Pay', fieldName: 'Gross_Pay__c', type: 'currency', typeAttributes: { currencyCode: 'USD'}},
        		{label: 'Taxes', fieldName: 'Taxes__c', type: 'currency', typeAttributes: { currencyCode: 'USD'}},
        		{label: 'Type', fieldName: 'Type__c', type: 'text'},
        		{label: 'Submitted', fieldName: 'Status__c', type: 'text'},
            ]);
    },
	// TOGGLE VIEW EVENT
    toggleView: function(cmp, event, helper) {
      if(cmp.find('inputToggle').get('v.checked')){
         var action = cmp.get("c.getRecentTimesheets");  
       }
     	else{
             var action = cmp.get("c.getTimesheets");
        }  
             
       action.setCallback(this, function(response) {
            //console.log(JSON.stringify(response.getReturnValue()));
            var state = response.getState();
            if (state === "SUCCESS") {
                var a = response.getReturnValue();
                //console.log(JSON.stringify(a))
                cmp.set("v.mydata", a);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
        var data = cmp.get("v.mydata");
        cmp.set('v.mycolumns', [
             	{label: 'Timesheet detail', fieldName: 'Id', type: 'text'},
                {label: 'Employee name', fieldName: 'Employee__r.Name', type: 'text'},
                {label: 'Start Date', fieldName: 'Start_Date__c', type: 'Date'},
                {label: 'End Date', fieldName: 'End_Date__c', type: 'Date'},
                {label: 'Total Hours', fieldName: 'Sum_Of_Hours__c', type: 'number'},
        		{label: 'Gross Pay', fieldName: 'Gross_Pay__c', type: 'currency', typeAttributes: { currencyCode: 'USD'}},
        		{label: 'Taxes', fieldName: 'Taxes__c', type: 'currency', typeAttributes: { currencyCode: 'USD'}},
        		{label: 'Type', fieldName: 'Type__c', type: 'text'},
        		{label: 'Submitted', fieldName: 'Status__c', type: 'text'}
            ]);
    },
	// HANDLE VIEW EVENT
	handleUpdateView: function(cmp, event, helper) {
        var updatedView = event.getParam("view");
        helper.updateView(cmp, updatedView);
    }
})