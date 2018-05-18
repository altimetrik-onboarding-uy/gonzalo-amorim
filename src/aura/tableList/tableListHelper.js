({
    // UPDATE VIEW HELPER
    updateView: function(cmp, view) {
        var action = cmp.get("c.updateView");
        action.setParams({
            "view": view
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // do nothing!
            }
        });
        $A.enqueueAction(action);
    }
})