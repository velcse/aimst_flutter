class ActivityLogModel {
  bool status;
  List<ActivityLogModelDetails> result;
  ActivityLogModel({required this.status, required this.result});

  factory ActivityLogModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogModel(
        status: json['status'],
        result: (json['result'] as List)
            .map((i) => ActivityLogModelDetails.fromJson(i))
            .toList());
  }
}

class ActivityLogModelDetails {
  String studentName;
  String totalkg;
  String slot;
  String created;
  String verifedBy;
  ActivityLogModelDetails(
      {required this.studentName,
      required this.totalkg,
      required this.slot,
      required this.created,
      required this.verifedBy});

  factory ActivityLogModelDetails.fromJson(Map<String, dynamic> json) {
    return ActivityLogModelDetails(
      studentName: (json['student_name'] != null) ? json['student_name'] : "",
      totalkg: (json['totalkg'] != null) ? json['totalkg'] : "",
      slot: (json['slot'] != null) ? json['slot'] : "",
      created: (json['created'] != null) ? json['created'] : "",
      verifedBy: (json['verifed_by'] != null) ? json['verifed_by'] : "",
    );
  }
}
