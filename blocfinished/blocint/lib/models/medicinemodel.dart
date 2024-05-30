// models/medicine_model.dart
class Medicine {
  final String title;
  final String detail;
  final String price;
  final String usedfor;
  final String category;

  Medicine({
    required this.title,
    required this.detail,
    required this.price,
    required this.usedfor,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'detail': detail,
      'price': price,
      'usedfor': usedfor,
      'category': category,
    };
  }
}
