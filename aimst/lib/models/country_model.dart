class CountryModel {
  bool status;
  List<CountryModelDetailsModel> result;
  CountryModel({required this.status, required this.result});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        status: json['status'],
        result: (json['result'] as List)
            .map((i) => CountryModelDetailsModel.fromJson(i))
            .toList());
  }
}

class CountryModelDetailsModel {
  String id;
  String name;
  CountryModelDetailsModel({required this.id, required this.name});

  factory CountryModelDetailsModel.fromJson(Map<String, dynamic> json) {
    return CountryModelDetailsModel(
        id: (json['id'] != null) ? json['id'] : "",
        name: (json['country_name'] != null) ? json['country_name'] : "");
  }
}
