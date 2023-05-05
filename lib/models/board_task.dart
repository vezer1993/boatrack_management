class BoardTask {
  int? accountId;
  int? charterId;
  String? task;
  String? priorityLevel;
  String? deadline;
  bool? resolved;

  BoardTask(
      {this.accountId,
        this.charterId,
        this.task,
        this.priorityLevel,
        this.deadline,
        this.resolved});

  BoardTask.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    charterId = json['charterId'];
    task = json['task'];
    priorityLevel = json['priorityLevel'];
    deadline = json['deadline'];
    resolved = json['resolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['charterId'] = this.charterId;
    data['task'] = this.task;
    data['priorityLevel'] = this.priorityLevel;
    data['deadline'] = this.deadline;
    data['resolved'] = this.resolved;
    return data;
  }
}