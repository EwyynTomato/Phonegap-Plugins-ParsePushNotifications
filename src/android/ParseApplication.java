package com.stratogos.cordova.parsePushNotifications;

import android.app.Application;
import com.parse.Parse;
import com.parse.ParseInstallation;
import com.parse.PushService;
import com.medium.hyperlocal.R;

public class ParseApplication extends Application
{

   public ParseApplication()
   {
      super();
   }

   public void onCreate()
   {
      Parse.initialize(getApplicationContext(), getString(R.string.parse_app_id), getString(R.string.parse_client_key));
      PushService.setDefaultPushCallback(getApplicationContext(), PushHandlerActivity.class);
      ParseInstallation.getCurrentInstallation().saveInBackground();
   }
}
