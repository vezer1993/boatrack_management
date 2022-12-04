import 'dart:convert';
import 'package:boatrack_management/models/notification_list.dart';
import 'package:boatrack_management/services/charter_api.dart';
import 'package:boatrack_management/services/web_services.dart';
import 'package:http/http.dart' as http;
import '../helpers/session.dart';
import '../models/charter.dart';
import '../models/notification.dart';
import '../resources/strings.dart';

Future getNotificationList() async {

  Charter temp = await getCharter();
  var response = await getResponse(StaticStrings.getNotificationListPath() + "/" + temp.id.toString()) as http.Response;
  String newJsonString = response.body;

  /// new notification element
  List<Notification> list = decodeJsonString(newJsonString);
  NotificationList notificationList = NotificationList(notifications: list, newNotifications: 0);

  ///GET SAVED NOTIFICATIONS
  if(SessionStorage.getValue(StaticStrings.getNotificationSession()) != null) {
    String savedJsonString =
        SessionStorage.getValue(StaticStrings.getNotificationSession()).toString();

    ///check for new notifications
    if(newJsonString != savedJsonString){
      //create list from old string
      List<Notification> oldList = decodeJsonString(savedJsonString);
      for(var not in list){
        if(oldList.where((element) => element.id == not.id).isEmpty){
          notificationList.newNotifications++;
        }
      }
    }
  }else{
    SessionStorage.saveValue(StaticStrings.getNotificationSession(), newJsonString);
  }

  return notificationList;
}

Future updateNotificationListSession() async {
  Charter temp = await getCharter();
  var response = await getResponse(StaticStrings.getNotificationListPath() + "/" + temp.id.toString()) as http.Response;
  String newJsonString = response.body;
  SessionStorage.saveValue(StaticStrings.getNotificationSession(), newJsonString);
}

List<Notification> decodeJsonString(String jsonString){
  var jsonMap = json.decode(jsonString);

  List<Notification> list = [];
  for(var json in jsonMap){
    Notification n = Notification.fromJson(json);
    list.add(n);
  }

  return list;
}