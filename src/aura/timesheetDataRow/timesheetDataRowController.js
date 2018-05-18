({
	// RECORD ID EDIT
    doEdit: function(cmp, event, helper) { 
    	var editRecordEvent = $A.get("e.force:editRecord");
        //console.log(editRecordEvent);
    	editRecordEvent.setParams({
         	"recordId": event.target.id
        });
        editRecordEvent.fire();
	},
	// SWITCH TO DETAIL VIEW
	navigate : function (cmp, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        //console.log(cmp.get("v.data"));
        navEvt.setParams({
            "recordId": cmp.get("v.data.Employee__c"),
            "slideDevName": "detail"
        });
        navEvt.fire();
	},
    // MINI VIEW IN
    miniViewIn : function (cmp, event, helper) {
        var id = 'div'+event.target.id;      
        if (document.getElementById(id).innerHTML == ""){
            var name = cmp.get("v.data.Employee__r.Name");
            var grosspay = cmp.get("v.data.Gross_Pay__c");
            var taxes = cmp.get("v.data.Taxes__c");
            var total_hours = cmp.get("v.data.Sum_Of_Hours__c");
            document.getElementById(id).innerHTML = "<tr><td scope='row'><strong>Employee Name: </strong>"+name+"<br></td><td scope='row'><strong> Gross Pay: </strong>"+grosspay+"</td><td scope='row'><strong> Taxes: </strong>"+
                taxes+"</td><td scope='row'><br><strong> Hours Worked: </strong>"+total_hours+"</td></tr>";
		}
    },
    // MINI VIEW OUT
    miniViewOut : function (cmp, event, helper) {
        var id = 'div'+event.target.id;
        if (document.getElementById(id).innerHTML != ""){
            document.getElementById(id).innerHTML = "";
        }
    }
})