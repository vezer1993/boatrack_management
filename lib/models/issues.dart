import 'issues_images.dart';

class IssueItem {
  int? id;
  String? name;
  String? description;
  int? checkinId;
  int? checkoutId;
  bool? hasPictures;
  int? cleaningId;
  int? yachtId;
  String? timestamp;
  String? resolutionNote;
  bool? resolved;
  String? document;
  String? checkin;
  String? checkout;
  String? cleaning;
  int? accountID;
  List<IssueImages>? issueImages;

  IssueItem(
      {this.id,
      this.name,
      this.description,
      this.checkinId,
      this.checkoutId,
      this.hasPictures,
      this.cleaningId,
      this.checkin,
      this.yachtId,
      this.checkout,
      this.cleaning,
      this.accountID,
      this.issueImages});

  IssueItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    resolutionNote = json['resolutionNote'];
    timestamp = json['timestamp'];
    document = json['document'];
    resolved = json['resolved'];
    checkoutId = json['checkoutId'];
    checkinId = json['checkinId'];
    hasPictures = json['hasPictures'];
    cleaningId = json['cleaningId'];
    checkin = json['checkin'];
    yachtId = json['yachtId'];
    checkout = json['checkout'];
    cleaning = json['cleaning'];
    accountID = json['accountId'];
    if (json['issueImages'] != null) {
      issueImages = <IssueImages>[];
      json['issueImages'].forEach((v) {
        issueImages!.add(new IssueImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['checkinId'] = this.checkinId;
    data['checkoutId'] = this.checkoutId;
    data['hasPictures'] = this.hasPictures;
    data['cleaningId'] = this.cleaningId;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['cleaning'] = this.cleaning;
    if (this.issueImages != null) {
      data['issueImages'] = this.issueImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<String> getImageList() {
    List<String> images = [];
    if (hasPictures!) {
      for(IssueImages img in issueImages!){
        images.add(img.imagePath.toString());
      }
    }

    return images;
  }
}
