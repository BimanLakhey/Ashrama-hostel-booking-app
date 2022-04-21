import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hotel_booking_app/utils/utilities.dart';

Future<void> bookingConfirmedNotification() async 
{
  await AwesomeNotifications().createNotification
  (
    content: NotificationContent
    (
      id: createUniqueId(), 
      channelKey: 'basic_channel',
      title: '${Emojis.paper_bookmark} Booking successful!!!',
      body: 'Please view your email for more booking details',
    )
  );
}