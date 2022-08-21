class CourseModel {
  bool status;
  List<CourseModelDetails> result;
  CourseModel({required this.status, required this.result});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        status: json['status'],
        result: (json['result'] as List)
            .map((i) => CourseModelDetails.fromJson(i))
            .toList());
  }
}

class CourseModelDetails {
  String id;
  String name;
  CourseModelDetails({required this.id, required this.name});

  factory CourseModelDetails.fromJson(Map<String, dynamic> json) {
    return CourseModelDetails(
        id: (json['id'] != null) ? json['id'] : "",
        name: (json['name'] != null) ? json['name'] : "");
  }
}

class FacultyModel {
  bool status;
  List<FacultyModelDetails> result;
  FacultyModel({required this.status, required this.result});

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
        status: json['status'],
        result: (json['result'] as List)
            .map((i) => FacultyModelDetails.fromJson(i))
            .toList());
  }
}

class FacultyModelDetails {
  String id;
  String name;
  FacultyModelDetails({required this.id, required this.name});

  factory FacultyModelDetails.fromJson(Map<String, dynamic> json) {
    return FacultyModelDetails(
        id: (json['id'] != null) ? json['id'] : "",
        name: (json['name'] != null) ? json['name'] : "");
  }
}

class RaceModel {
  bool status;
  List<RaceModelDetails> result;
  RaceModel({required this.status, required this.result});

  factory RaceModel.fromJson(Map<String, dynamic> json) {
    return RaceModel(
        status: json['status'],
        result: (json['result'] as List)
            .map((i) => RaceModelDetails.fromJson(i))
            .toList());
  }
}

class RaceModelDetails {
  String id;
  String name;
  RaceModelDetails({required this.id, required this.name});

  factory RaceModelDetails.fromJson(Map<String, dynamic> json) {
    return RaceModelDetails(
        id: (json['id'] != null) ? json['id'] : "",
        name: (json['name'] != null) ? json['name'] : "");
  }
}
