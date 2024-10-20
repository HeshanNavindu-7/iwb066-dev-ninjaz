class ProductService {
  final int productId;
  final String productName;
  final int price;
  final String category;
  final String productDetails;
  final String? imagePath; // Optional imagePath

  ProductService({
    required this.productId,
    required this.productName,
    required this.price,
    required this.category,
    required this.productDetails,
    this.imagePath,
  });

  // Factory method to create a ProductService object from JSON
  factory ProductService.fromJson(Map<String, dynamic> json) {
    return ProductService(
      productId:
          json['product_id'] ?? 0, // Default value to handle missing field
      productName:
          json['product_name'] ?? 'Unnamed Product', // Default to avoid null
      price: json['price'] ?? 0, // Ensure price is an integer or default
      category: json['category'] ?? 'Uncategorized',
      productDetails: json['product_details'] ?? 'No details available',
      imagePath: json['image_path'], // Nullable field
    );
  }

  // Optional method for converting ProductService to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'category': category,
      'product_details': productDetails,
      'image_path': imagePath,
    };
  }
}
