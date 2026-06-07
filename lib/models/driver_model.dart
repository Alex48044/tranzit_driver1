class DriverModel {
  final int id;
  final String phone;
  final String name;
  final String? carModel;
  final String? carNumber;
  bool isOnline;

  DriverModel({
    required this.id,
    required this.phone,
    required this.name,
    this.carModel,
    this.carNumber,
    this.isOnline = false,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] as int,
      phone: json['phone'] as String,
      name: json['name'] as String,
      carModel: json['carModel'] as String?,
      carNumber: json['carNumber'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }
}
