package com.stratogos.cordova.parsePushNotifications;

import android.app.Application;
import com.parse.Parse;
import com.parse.ParseInstallation;
import com.parse.PushService;

public class ParseApplication extends Application
{

   public ParseApplication()
   {
      super();
   }

   public void onCreate()
   {
      // TODO: Tomato, tokenize id and key to be inserted by Grunt
      Parse.initialize(getApplicationContext(), "tIm8aiNUNF5x4Uv8MZ5jEmITYE5AEHC1uPnsOP18", "sY1bFjAoLC8LzQ3RPS71jgJnFGNNsjIcXVE8b3OO");
      PushService.setDefaultPushCallback(getApplicationContext(), PushHandlerActivity.class);
      ParseInstallation.getCurrentInstallation().saveInBackground();
   }
}
