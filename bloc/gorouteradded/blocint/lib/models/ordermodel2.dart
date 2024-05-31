class Order2 {
  final String id;
  final String medicine;
  final String date;
  final String ordererId;
  final String medId;
  final String quantity;

  Order2({
    required this.id,
    required this.medicine,
    required this.date,
    required this.ordererId,
    required this.medId,
    required this.quantity,
  });

  factory Order2.fromJson(Map<String, dynamic> json, String medTitle) {
    return Order2(
      id: json['_id'],
      medicine: medTitle,
      date: json['date'],
      ordererId: json['userId'],
      medId: json['medicineId'],
      quantity: json['quantity'],
    );
  }
}
