class GroceriesPayload {
  int? categoryId;
  String? categoryName;
  String? name;
  String? description;
  int? stock;
  int? price;
  String? image;

  GroceriesPayload({
    this.categoryId,
    this.categoryName,
    this.name,
    this.description,
    this.stock,
    this.price,
    this.image,
  });

  factory GroceriesPayload.fromJson(Map<String, dynamic> json) =>
      GroceriesPayload(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        name: json["name"],
        description: json["description"],
        stock: json["stock"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "name": name,
        "description": description,
        "stock": stock,
        "price": price,
        "image": image,
      };
}
