class MedicineItem {
  final String medid;
  final String title;
  final String description;
  final String price;
  final String category;
  final String usedfor;

  MedicineItem({
    required this.medid,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.usedfor
  });

  factory MedicineItem.fromJson(Map<String, dynamic> json) {
    return MedicineItem(
      medid: json['_id'],
      title: json['title'],
      description: json['detail'],
      price: 'Price: ${json['price']} Birr',
      category: 'Category: ${json['category']}',
      usedfor: json['usedfor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': medid,
      'title': title,
      'detail': description,
      'price': price.split(' ')[1], // Assuming format "Price: 100 Birr"
      'category': category.split(' ')[1], // Assuming format "Category: XYZ"
      'usedfor': usedfor,
    };
  }
}
