class OrderModel {
  final int id;
  final String fromAddress;
  final String toAddress;
  final String passengerPhone;
  final String? passengerName;
  final double price;
  final String status; // new, accepted, started, completed, cancelled

  OrderModel({
    required this.id,
    required this.fromAddress,
    required this.toAddress,
    required this.passengerPhone,
    this.passengerName,
    required this.price,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      fromAddress: json['fromAddress'] as String,
      toAddress: json['toAddress'] as String,
      passengerPhone: json['passengerPhone'] as String,
      passengerName: json['passengerName'] as String?,
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
    );
  }
}
