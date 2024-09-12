class GroceriesModel {
  String id;
  String imageUrl;
  String title;
  String desc;
  String price;

  GroceriesModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.price,
  });
}

List<GroceriesModel> groceriesItems = [
  GroceriesModel(
    id: '1',
    imageUrl:
        'https://www.budgetbytes.com/wp-content/uploads/2022/08/Avocado-Tomato-Salad-above.jpg',
    title: 'Avocado Salad',
    price: '12.000',
    // rate: 4.5,
    // kcal: '100',
    // cookingTime: '20min',
    desc: "test.",
  ),
  GroceriesModel(
      id: '2',
      imageUrl:
          'https://c8.alamy.com/comp/F2F1E4/royal-hamburger-isolated-F2F1E4.jpg',
      title: 'Royal Burger',
      price: '12.000',
      // rate: 5.0,
      // kcal: '100',
      // cookingTime: '30min',
      desc: "test"),
  GroceriesModel(
    id: '3',
    imageUrl:
        'https://www.modernhoney.com/wp-content/uploads/2023/05/Fruit-Salad-10.jpg',
    title: 'Fruit Salad',
    price: '15.000',
    // rate: 4.6,
    // kcal: '20',
    // cookingTime: '15min',
    desc: "test",
  ),
  GroceriesModel(
    id: '4',
    imageUrl:
        'https://imageUrls.immediate.co.uk/production/volatile/sites/30/2020/08/the-health-benefits-of-nuts-main-imageUrl-700-350-bb95ac2.jpg?resize=768,574',
    title: 'Mix Nut',
    price: '30.000',
    // rate: 5.0,
    // kcal: '160',
    // cookingTime: '08min',
    desc: "test.",
  ),
  GroceriesModel(
    id: '5',
    imageUrl:
        "https://www.eatingbirdfood.com/wp-content/uploads/2023/02/strawberry-protein-shake-hero-new-cropped.jpg",
    title: 'Protein Shake',
    price: '50.000',
    // rate: 4.8,
    // kcal: '100',
    // cookingTime: '05min',
    desc: "test",
  ),
  GroceriesModel(
    id: '5',
    imageUrl: "https://m.media-amazon.com/imageUrls/I/61LojzJ+PuL._SL1000_.jpg",
    title: 'Dairy Milk',
    price: '5.000',
    // rate: 5.0,
    // kcal: '10',
    // cookingTime: 'Ready',
    desc: "test",
  ),
];
