import 'package:boatrack_management/helpers/calendar_calculations.dart';
import 'package:boatrack_management/models/charter.dart';

import '../helpers/conversions.dart';
import 'booking.dart';
import 'check_model.dart';
import 'cleaning.dart';

class Yacht {
  int? id;
  int? charterId;
  String? name;
  String? model;
  String? year;
  String? lenght;
  String? homebase;
  String? image;
  String? updateId;
  String? availability;
  int? checkModelId;
  bool? isBeingCleaned;
  String? teltonikaId;
  Charter? charter;
  CheckModel? checkModel;
  List<Booking>? bookings;
  List<Cleaning>? cleanings;

  Yacht(
      {this.id,
        this.charterId,
        this.name,
        this.model,
        this.year,
        this.lenght,
        this.homebase,
        this.image,
        this.updateId,
        this.availability,
        this.charter,
        this.bookings});

  Yacht.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    charterId = json['charterId'];
    name = json['name'];
    model = json['model'];
    year = json['year'];
    lenght = json['lenght'];
    homebase = json['homebase'];
    image = json['image'];
    updateId = json['updateId'];
    availability = json['availability'];
    charter = json['charter'];
    isBeingCleaned = json['isBeingCleaned'];
    teltonikaId = json['teltonikaId'];
    checkModelId = json['checkModelId'];
    if (json['bookings'] != null) {
      bookings = <Booking>[];
      json['bookings'].forEach((v) {
        bookings!.add(Booking.fromJson(v));
      });
    }
    if (json['cleanings'] != null) {
      cleanings = <Cleaning>[];
      json['cleanings'].forEach((v) {
        cleanings!.add(Cleaning.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['charterId'] = this.charterId;
    data['name'] = this.name;
    data['model'] = this.model;
    data['year'] = this.year;
    data['lenght'] = this.lenght;
    data['homebase'] = this.homebase;
    data['image'] = this.image;
    data['updateId'] = this.updateId;
    data['availability'] = this.availability;
    data['checkModelId'] = this.checkModelId;
    data['isBeingCleaned'] = this.isBeingCleaned;
    data['teltonikaId'] = this.teltonikaId;
    data['charter'] = this.charter;
    data['checkModel'] = this.checkModel;
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    if (this.cleanings != null) {
      data['cleanings'] = this.cleanings!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  double getTotalRevenue(){
    double revenue = 0;
    if(bookings != null){
      List<Booking> bookings = this.bookings!;

      for(Booking b in bookings){
        if(b.priceFinal != null){
          revenue = revenue + double.parse(b.priceFinal.toString());
        }
      }
    }
    return revenue;
  }

  double getWeeksOut(){
    double weeks = 0;
    if(availability != null){
      for(int i = 0; i < availability!.length; i = i+7){
        if(availability![i] == "1"){
          weeks++;
        }
      }
    }
    return weeks;
  }

  String availabilityForWeek(int week){
    week = week - 1;
    if(availability != null){
      List<String> availabilityArray = List<String>.generate(
          availability!.length,
              (index) => availability![index]);
      if(2+(7*week) < 365){
        return availabilityArray[2+(7*week)];
      }
    }
    return "0";
  }

  Booking? getBookingForDate(){
    Booking? result;
    int thisWeek = CalendarCalculations().getTodayWeekNumber();

    if(bookings != null) {
      for(Booking b in bookings!){
        /*int bookingStart = CalendarCalculations().getWeekNumberForDate(Conversion.convertUtcTimeDateTime(b.datefrom.toString()));
        int bookingEnd = CalendarCalculations().getWeekNumberForDate(Conversion.convertUtcTimeDateTime(b.dateto.toString()));

        bookingEnd--;
        while(bookingStart <= bookingEnd){
          if(bookingEnd == thisWeek){
            result = b;
          }
          bookingEnd--;
        }

         */

        DateTime start = Conversion.convertUtcTimeDateTime(b.datefrom.toString());
        DateTime finish = Conversion.convertUtcTimeDateTime(b.dateto.toString());
        DateTime now = DateTime.now();

        if(now.isAfter(start) && now.isBefore(finish)){
          return b;
        }
      }
    }

    return result;
  }

  List<Booking>? getBookingList(){
    if(bookings == null){
      return null;
    }else{
      bookings?.sort((a, b) => a.datefrom!.compareTo(b.datefrom.toString()));
      return bookings;
    }
  }
}