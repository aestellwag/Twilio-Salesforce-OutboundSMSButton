({
  getSmsRequest: function (component, id, message, userId) {
    console.log("in helper");
    console.log("id: " + id);
    console.log("message: " + message);
    console.log("userId:" + userId);

    var action = component.get("c.sendSmsApexRequest");
    action.setParams({
      id: id,
      message: message,
      userId: userId,
    });
    action.setCallback(this, function (response) {
      var state = response.getState();
      console.log(state);
      if (component.isValid() && state === "SUCCESS") {
        // get response data
        component.set("v.response", response.getReturnValue());
        console.log("=============SUCCESS============");
        console.log(response.getReturnValue());

        // auto-close the modal
        $A.get("e.force:closeQuickAction").fire();
      }
    });
    $A.enqueueAction(action);
    // Refresh cache as it is required for the userId we are passing to the Apex Class
    // I was running into a race condition and userId was coming back null in the Apex Class sometimes
    $A.get("e.force:refreshView").fire();
  },
});
