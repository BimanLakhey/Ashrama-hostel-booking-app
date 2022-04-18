import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

main() async {
  String username = 'biman.lakhey74@gmail.com';
  String password = 'Hesoyam74';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.  

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Biman lakhey')
    ..recipients.add('lakheyimmortal123@gmail.com')
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Test mail'
    ..text = 'Hello world';
    // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  final equivalentMessage = Message()
    ..from = Address(username, 'biman')
    ..recipients.add(Address('biman.lakhey73@gmail.com'))
    // ..ccRecipients.addAll([Address('lakheyimmortal123@gmail.com'), 'kishansah271@icloud.com'])
    // ..bccRecipients.add('bccAddress@example.com')
    ..subject = 'Test mail'
    ..text = 'Hello world';
    // ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
    // ..attachments = [
    //   FileAttachment(File('lib\\images\\ss.png'))
    //     ..location = Location.inline
    //     ..cid = '<myimg@3.141>'
    // ];

  final sendReport2 = await send(equivalentMessage, smtpServer);

  // Sending multiple messages with the same connection
  //
  // Create a smtp client that will persist the connection
  var connection = PersistentConnection(smtpServer);

  // Send the first message
  await connection.send(message);

  // send the equivalent message
  await connection.send(equivalentMessage);

  // close the connection
  await connection.close();
}