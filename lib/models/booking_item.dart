import 'package:boatrack_management/helpers/conversions.dart';
import 'package:boatrack_management/resources/formats.dart';

class BookingItem {
  String? name;
  double? quantity;
  String? unit;
  double? price;
  bool? payableInBase;

  String getQuantity (){
    if(unit == "PERCENTAGE"){
      return quantity.toString() + " %";
    }

    return quantity.toString();
  }

  String getPrice (){
    return Conversion.priceConversion(price!);
  }

  BookingItem(
      {this.name, this.quantity, this.unit, this.price, this.payableInBase});

  BookingItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    unit = json['unit'];
    price = json['price'];
    payableInBase = json['payableInBase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['payableInBase'] = this.payableInBase;
    return data;
  }
}