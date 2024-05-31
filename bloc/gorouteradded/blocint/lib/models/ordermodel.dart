// models/order.dart
class Order {
  final String? id;
  final String medicineId;
  final int quantity;
  final DateTime date;
  final String userId;

  Order({
    this.id,
    required this.medicineId,
    required this.quantity,
    required this.date,
    required this.userId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      medicineId: json['medicineId'],
      quantity: int.parse(json['quantity']),
      date: DateTime.parse(json['date']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'quantity': quantity.toString(),
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }
}
