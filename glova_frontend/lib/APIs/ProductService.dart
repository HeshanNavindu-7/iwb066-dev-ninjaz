class ProductService {
  final int productId;
  final String productName;
  final int price;
  final String category;
  final String productDetails;
  final String? imagePath;

  ProductService({
    required this.productId,
    required this.productName,
    required this.price,
    required this.category,
    required this.productDetails,
    this.imagePath,
  });

  // Factory method to create a Product from JSON
  factory ProductService.fromJson(Map<String, dynamic> json) {
    return ProductService(
      productId: json['product_id'],
      productName: json['product_name'],
      price: json['price'],
      category: json['category'],
      productDetails: json['product_details'],
      imagePath: json['image_path'],
    );
  }
}
