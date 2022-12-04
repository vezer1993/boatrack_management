class EmployeeTask {
  int? id;
  String? taskName;
  String? taskType;
  int? typeId;
  int? accountId;
  bool? resolved;
  int? charterId;
  String? timeCreated;
  String? timeResolved;

  EmployeeTask(
      {this.id,
        this.taskName,
        this.taskType,
        this.typeId,
        this.accountId,
        this.resolved,
        this.charterId,
        this.timeCreated,
        this.timeResolved});

  EmployeeTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['taskName'];
    taskType = json['taskType'];
    typeId = json['typeId'];
    accountId = json['accountId'];
    resolved = json['resolved'];
    charterId = json['charterId'];
    timeCreated = json['timeCreated'];
    timeResolved = json['timeResolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskName'] = this.taskName;
    data['taskType'] = this.taskType;
    data['typeId'] = this.typeId;
    data['accountId'] = this.accountId;
    data['charterId'] = this.charterId;
    return data;
  }
}