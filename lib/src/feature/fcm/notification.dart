
import 'package:awesome_notifications/awesome_notifications.dart';

scheduleNotification(DateTime time)async{

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: time.millisecondsSinceEpoch,
        channelKey: 'scheduled',
        title: 'Just in time!',
        body: 'This notification was scheduled to shows at ' +
            time.toLocal().toString() +
            time.timeZoneName+'(' +
            time.toUtc().toString() +
            ' utc)',
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/images/delivery.jpeg',
        payload: {'uuid': 'uuid-test'},
        autoDismissible: false,
      ),
      schedule: NotificationCalendar.fromDate(date: time),);
}