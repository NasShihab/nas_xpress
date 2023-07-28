class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final double price;
  final double ratings;
  final String category;

  Product({
    this.id ='',
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.ratings,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
      ratings: json['ratings'].toDouble(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'category': category,
    };
  }
}
