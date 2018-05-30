({
	// RECORD ID EDIT
    doEdit: function(cmp, event, helper) { 
    	var editRecordEvent = $A.get("e.force:editRecord");
    	editRecordEvent.setParams({
         	"recordId": event.target.id
        });
        editRecordEvent.fire();
	},
	// SWITCH TO DETAIL VIEW
	navigate : function (cmp, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
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
    },
    
    // RECEIVED EVENT FROM PARENT CMP
    gotEvent : function(cmp, event) {
        var myReceivedBox = event.getParam('cbox')
        var TheCheckBox = cmp.find("cboxRow");
        TheCheckBox.set("v.value", myReceivedBox);
    },
    
    // FIRE EVENT TO PARENT CMP
    sendRecord : function(cmp, event) {
        var appEvent = $A.get("e.c:passRecord");
        var checkSelected = cmp.get("v.checkSelected");
        var myRecord = cmp.get("v.data.Id");
	        appEvent.setParams({
                "recordId" : myRecord,
                "isSelected" : checkSelected });
	        appEvent.fire();
    }
})