class Meal {
  String title;
  String imageUrl;
  List<String> ingredients;
  String portion;
  //String currency;
  double price;

  Meal({
    //this.currency = '\$',
    this.imageUrl,
    this.portion,
    this.price,
    this.title,
    this.ingredients,
  });
}
