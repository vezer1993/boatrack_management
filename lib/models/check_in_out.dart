import 'issues.dart';

class CheckInOut {
  int? id;
  String? name;
  bool? isSkipper;
  String? email;
  String? signature;
  bool? issues;
  String? document;
  String? timestamp;
  List<String>? bookings;
  List<IssueItem>? issuesNavigation;

  CheckInOut(
      {this.id,
        this.name,
        this.isSkipper,
        this.email,
        this.signature,
        this.issues,
        this.document,
        this.bookings,
        this.issuesNavigation});

  CheckInOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSkipper = json['isSkipper'];
    email = json['email'];
    signature = json['signature'];
    issues = json['issues'];
    document = json['document'];
    timestamp = json['timestampData'];
    bookings = json['bookings'].cast<String>();
    if (json['issuesNavigation'] != null) {
      issuesNavigation = <IssueItem>[];
      json['issuesNavigation'].forEach((v) {
        issuesNavigation!.add(IssueItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isSkipper'] = this.isSkipper;
    data['email'] = this.email;
    data['signature'] = this.signature;
    data['issues'] = this.issues;
    data['document'] = this.document;
    data['bookings'] = this.bookings;
    if (this.issuesNavigation != null) {
      data['issuesNavigation'] =
          this.issuesNavigation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}