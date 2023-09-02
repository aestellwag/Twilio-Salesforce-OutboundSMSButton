({
  doInit: function (component, event, helper) {
    var currency = "USD";
    var id = component.get("v.recordId");
  },
  // controller method to send the sms message via the helper method
  sendMessage: function (component, event, helper) {
    var message = component.get("v.myMessage");
    var id = component.get("v.recordId");
    helper.getSmsRequest(component, id, message);
  },
  // controller used to update the message value from the helper method if they enter free text in the textarea
  updateMessage: function (component, event, helper) {
    var updatedMessage = event.getSource().get("v.value");
    component.set("v.myMessage", updatedMessage);
  },
  // populate message from pre-formatted response
  changeOptions: function (component, event) {
    var selectedValue = event.getParam("value");
    component.set("v.myMessage", selectedValue);
  },
});
