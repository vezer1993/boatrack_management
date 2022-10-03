class Cleaning {

  int? id;
  int? yachtId;
  int? boookingId;
  int? accountId;
  String? timeStarted;
  String? timeFinished;
  bool? hasIssues;
  String? employee;

  Cleaning(
      {this.id,
        this.yachtId,
        this.boookingId,
        this.accountId,
        this.timeStarted,
        this.timeFinished,
        this.hasIssues});

  Cleaning.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yachtId = json['yachtId'];
    boookingId = json['boookingId'];
    accountId = json['accountId'];
    timeStarted = json['timeStarted'];
    timeFinished = json['timeFinished'];
    hasIssues = json['hasIssues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yachtId'] = this.yachtId;
    data['accountId'] = this.accountId;
    data['timeStarted'] = this.timeStarted;
    data['timeFinished'] = this.timeFinished;
    data['hasIssues'] = this.hasIssues;
    return data;
  }
}