import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';


class notification {
  notificationInitialiser() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
  }

  instantNotify() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'Medi-Connect',
      body: 'Welcome to Medi-Connect',
    ));
  }

  scheduleNotification(DateTime time,String body,String title,bool repeats) async {
    bool permissions = await AwesomeNotifications().isNotificationAllowed();
    if (!permissions) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: time.day,
        channelKey: 'basic_channel',
        title: title,
        // body: 'This notification was scheduled to shows at ' +
        //     time.toLocal().toString() +
        //     time.timeZoneName +
        //     '(' +
        //     time.toUtc().toString() +
        //     ' utc)',
        body: body,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.BigPicture,
        payload: {'uuid': 'uuid-test'},
        autoDismissible: false,

      ),
      schedule: NotificationCalendar.fromDate(date: time,repeats: repeats),
    );
  }
}
