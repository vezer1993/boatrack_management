import 'dart:convert';
import 'package:boatrack_management/models/booking_preparation.dart';
import 'package:boatrack_management/services/web_services.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/session.dart';
import '../models/charter.dart';
import '../models/guest.dart';
import '../resources/strings.dart';
import 'charter_api.dart';

Future getBookingList() async {

  Charter temp = await getCharter();
  var response = await getResponse(StaticStrings.getPathYachtList() + "/" + temp.id.toString()) as http.Response;

}

Future setGuestsArrived(BuildContext context, String bookingID) async {
  var response = await putResponseNoBody(context, StaticStrings.getPathBookingArrival() + "/" + bookingID) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}

Future putBookingNote(String bookingID, String note, BuildContext context) async{
  String path = StaticStrings.getPathBooking() + "/" + bookingID.toString() + StaticStrings.getPathBookingNote();
  Map<String, String> param = {};
  param[StaticStrings.getPathBookingNoteParam()] = note;
  var response = await putResponse(context, path, param) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    await updateYachtList();
    return true;
  }else{
    return false;
  }
}

Future postGuestInformation(String bookingID, String crewCount, Guest topG, BuildContext context) async{
  var response = await postResponse(StaticStrings.getPathBookingPostGuest() + "/" + bookingID + "/" + crewCount, topG.toJson(), context) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    await updateYachtList();
    return true;
  }else{
    return false;
  }
}

Future getGuest(String guestID) async {
  var response = await getResponse(StaticStrings.getPathBookingPostGuest() + "/" + guestID) as http.Response;
  var jsonVar = json.decode(response.body);
  Guest topG = Guest.fromJson(jsonVar);
  return(topG);
}

Future getBookingPreparationStatus(String bookingID) async {
  var response = await getResponse(StaticStrings.getPathBookingPreparation() + "/" + bookingID) as http.Response;
  var jsonVar = json.decode(response.body);
  BookingPreparation bp = BookingPreparation.fromJson(jsonVar);
  return(bp);
}