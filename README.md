# Flutter notfication example

A new Flutter application to test nested notifications.

## nested notifications on android and ios

I used flutter_local_notifications pub package to create notifications in this flutter app. First I had to initialize the settings required for the notifications to work. It sets up android permissions by itself so didnt had to do anything but in iOS I had to set up a user notification delegate. Also initialized a callback for when notification is clicked on.

### Grouping

For android you have to specify the notification group params for them to stick to one group. Later it is merged into a Android Inbox style notification under the same summary.
For iOS, all notification under same thread ID are grouped automatically so did not do anything for that.
I specefied all required values in NotificationDetails constructor for each plaform.

I have also created different layouts for Android and IOS.
It can be differntitated using a simple platform value check.