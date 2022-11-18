class DistrictModel {
  String id;
  String name;
  String cityId;

  DistrictModel({required this.id, required this.name, required this.cityId});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] as String,
      name: json['name'] as String,
      cityId: json['city_id'] as String,
    );
  }
}
