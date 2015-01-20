var exec = require('cordova/exec');
var pluginNativeName = "ParsePushNotificationPlugin";

var ParsePushPlugin = function() {
};

ParsePushPlugin.prototype = {
  init: function(options, successCallback, errorCallback) {
    exec(successCallback, errorCallback, pluginNativeName, 'init', [options]);
  },
  register: function(options, successCallback, errorCallback) {
    exec(successCallback, errorCallback, pluginNativeName, 'register', [options]);
  }
};

module.exports = new ParsePushPlugin();
