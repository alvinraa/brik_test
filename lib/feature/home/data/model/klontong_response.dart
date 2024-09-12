class GroceriesModel {
  String? id;
  int? categoryId;
  String? categoryName;
  String? name;
  String? description;
  int? stock;
  int? price;
  String? image;

  GroceriesModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.name,
    this.description,
    this.stock,
    this.price,
    this.image,
  });

  factory GroceriesModel.fromJson(Map<String, dynamic> json) => GroceriesModel(
        id: json["_id"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        name: json["name"],
        description: json["description"],
        stock: json["stock"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "name": name,
        "description": description,
        "stock": stock,
        "price": price,
        "image": image,
      };
}
