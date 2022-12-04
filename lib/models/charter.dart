import 'package:boatrack_management/models/booking.dart';
import 'package:boatrack_management/models/yacht.dart';
import 'account.dart';

class Charter {
  int? id;
  String? name;
  String? bmkey;
  String? teltonikaToken;
  List<Accounts>? accounts;
  List<Booking>? bookings;
  List<Yacht>? yachts;

  Charter(
      {this.id,
      this.name,
      this.bmkey,
      this.teltonikaToken,
      this.accounts,
      this.bookings,
      this.yachts});

  Charter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bmkey = json['bmkey'];
    teltonikaToken = json['teltonikaToken'];
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(Accounts.fromJson(v));
      });
    }
    if (json['bookings'] != null) {
      bookings = <Booking>[];
      json['bookings'].forEach((v) {
        bookings!.add(  Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bmkey'] = this.bmkey;
    data['teltonikaToken'] = this.teltonikaToken;
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
