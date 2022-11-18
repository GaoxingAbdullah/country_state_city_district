class StreetAddressModel {
  String id;
  String address;
  String districtId;
  StreetAddressModel(
      {required this.id, required this.address, required this.districtId});

  factory StreetAddressModel.fromJson(Map<String, dynamic> json) {
    return StreetAddressModel(
      id: json['id'] as String,
      address: json['address'] as String,
      districtId: json['district_id'] as String,
    );
  }
}
