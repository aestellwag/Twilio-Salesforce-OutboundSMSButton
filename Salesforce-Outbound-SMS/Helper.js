({
  getSmsRequest: function (component, id, message) {
    console.log("in helper");
    console.log("id: " + id);
    console.log("message: " + message);

    var action = component.get("c.sendSmsApexRequest");
    action.setParams({
      id: id,
      message: message,
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
  },
});
