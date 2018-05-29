({// LOAD MAIN TABLE
    init: function (cmp, event, helper) {
        var action = cmp.get("c.getTimesheets");
        var toggleView = cmp.get("c.toggleView");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var a=response.getReturnValue();
                cmp.set("v.mydata", a);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
        $A.enqueueAction(toggleView);
        cmp.set('v.mycolumns', [
             	{label: 'Timesheet detail', fieldName: 'Id', type: 'text'},
                {label: 'Employee name', fieldName: 'Employee__r.Name', type: 'text'},
                {label: 'Start Date', fieldName: 'Start_Date__c', type: 'Date'},
                {label: 'End Date', fieldName: 'End_Date__c', type: 'Date'},
                {label: 'Total Hours', fieldName: 'Sum_Of_Hours__c', type: 'number'},
        		{label: 'Gross Pay', fieldName: 'Gross_Pay__c', type: 'currency', typeAttributes: { currencyCode: 'USD'}},
        		{label: 'Taxes', fieldName: 'Taxes__c', type: 'currency', typeAttributes: { currencyCode: 'USD'}},
        		{label: 'Type', fieldName: 'Type__c', type: 'text'},
        		{label: 'Status', fieldName: 'Status__c', type: 'text'},
             	{label: 'Submitted', fieldName: 'Submitted__c', type: 'text'},
            ]);
    },
	// TOGGLE VIEW EVENT
    toggleView: function(cmp, event, helper) {
    	var togglerStatus = cmp.get("v.toggler");
        var changeValue = cmp.get("v.value");
        var myBool = cmp.get("v.myBool");
        // LOGIC FOR WORKING ON FILTER OPTIONS AND TOOGLE
        if(cmp.find('inputToggle').get('v.checked')){
            cmp.set("v.myBool", false);
             if(togglerStatus && changeValue == 'option3'){
             	var action = cmp.get("c.getRecentTimesheets");
             } else if (togglerStatus && changeValue == 'option1'){
             	var action = cmp.get("c.filterTimesheets");
             } else {
             	var action = cmp.get("c.filterNotSubmitted");
             }     
       } else {
            cmp.set("v.myBool", false);
             if(changeValue == 'option1'){
             	var action = cmp.get("c.submittedTimesheets");
             } else if (changeValue == 'option2'){
             	var action = cmp.get("c.notSubmittedTimesheets");
             } else if(changeValue == 'option3') {
             	var action = cmp.get("c.getTimesheets");
             }
        }     
       action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var a = response.getReturnValue();
                cmp.set("v.mydata", a);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    // SELECT ALL BOXES IN CHECKBOX EVENT
    checkAllBoxes : function(cmp, event) {
        // Get the application event by using the
        // e.<namespace>.<event> syntax
        var appEvent = $A.get("e.c:selectBox");
        var myBool = cmp.get("v.myBool");
        var mydata = cmp.get("v.mydata");
        var myList = cmp.get("v.myRecordList");
        cmp.set("v.myRecordList", []);
        if(myBool){
            for(var i=0; i<mydata.length; i++){
                myList.push(mydata[i].Id);
            }
            cmp.set("v.myRecordList", myList);
        }
        appEvent.setParams({
            "cbox" : myBool});
        appEvent.fire();
    },
    
    // UPDATE LIST & LOGIC FOR PARENT TOGGLE
    updateList : function(cmp, event) {
        var myRecord = event.getParam("recordId");
        var selection = event.getParam("isSelected");
        var myList = cmp.get("v.myRecordList");
        if (selection == true) {
            myList.push(myRecord);
            cmp.set("v.myRecordList", myList);
            var mydata = cmp.get("v.mydata");
            if(mydata.length == myList.length){
                cmp.set("v.myBool", true);
            }
        } else {
            var myBool = cmp.get("v.myBool");
            cmp.set("v.myBool", false);
            myList.pop(myRecord);
            cmp.set("v.myRecordList", myList);
            var mydata = cmp.get("v.mydata");
            if(mydata.length == myList.length){
                cmp.set("v.myBool", true);
            }
        }
    },
    
    // SUBMIT SELECTED TIMESHEETS AND CHANGE STATUS TO 'SUBMITTED'
    submitSelected : function(cmp, event, helper) {
        var myBool = cmp.get("v.myBool");
        cmp.set("v.myBool", false);
        var listForSubmit = cmp.get("v.myRecordList");
        // VALIDATION FOR EMPTY TIMESHEET SUBMIT
        if(listForSubmit.length == 0){
            alert("You haven't selected any Timesheets, please select a record to submit.");
        }
        var action = cmp.get("c.myReceivedList");
        action.setParams({
            'myList' : listForSubmit
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var a = response.getReturnValue();
                var b = cmp.get('c.init');
                $A.enqueueAction(b);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    }
})