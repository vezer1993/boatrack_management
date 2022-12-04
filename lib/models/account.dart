class Accounts {
  int? id;
  int? charterId;
  String? name;
  String? username;
  String? password;
  bool? isAdmin;
  String? pin;
  String? charter;
  List<String>? cleanings;

  Accounts({this.id,
    this.charterId,
    this.name,
    this.username,
    this.password,
    this.isAdmin,
    this.pin,
    this.charter,
    this.cleanings});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    charterId = json['charterId'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    isAdmin = json['isAdmin'];
    pin = json['pin'];
    charter = json['charter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charterId'] = this.charterId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['isAdmin'] = this.isAdmin;
    data['pin'] = this.pin;
    data['charter'] = this.charter;
    data['cleanings'] = this.cleanings;
    return data;
  }
}