import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class MealCard extends StatelessWidget {
  final String title;
  final List<String> ingredients;
  final String imageUrl;
  final String portion;
  final String currency;
  final double price;
  final int numberOfColumns;
  final int i;
  MealCard({
    this.i,
    this.numberOfColumns,
    this.currency,
    this.imageUrl,
    this.ingredients,
    this.portion,
    this.price,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //WORKAROUND: according to https://github.com/flutter/flutter/issues/25009
      decoration: BoxDecoration(
        color: colorBackground, //the color of the main container
        border: Border.all(
          //apply border to only that side where the line is appearing i.e. top | bottom | right | left.
          width: kMealCardMargin, //depends on the width of the unintended line
          color: colorBackground,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: ((i + numberOfColumns + 1) % (numberOfColumns + 1) == 0) ? kMealCardMargin : 0,
          right: ((i + numberOfColumns + 1) % (numberOfColumns + 1) == numberOfColumns) ? kMealCardMargin : 0,
          bottom: kMealCoverSize / 2,
        ),
        decoration: BoxDecoration(
          color: colorBackground,
          //color: Colors.amber,
        ),
        child: Stack(children: [
          MealBox(
            title: title,
            price: price,
            portion: portion,
            ingredients: ingredients,
          ),
          MealCover(imageUrl: imageUrl),
        ]),
        //margin: EdgeInsets.all(0),
      ),
    );
  }
}

class MealCover extends StatelessWidget {
  final String imageUrl;
  MealCover({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: kMealCoverSize,
        width: kMealCoverSize,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
          //color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(kMealCoverCornerRadius)),
        ),
      ),
    );
  }
}

class MealBox extends StatelessWidget {
  final String title;
  final List<String> ingredients;
  final String portion;
  //final String currency;
  final double price;
  MealBox({
    //this.currency,
    this.ingredients,
    this.portion,
    this.price,
    this.title,
  });

  String ingredientsText(List<String> ingredients) {
    String out = '';
    for (String ingredient in ingredients) {
      out += ingredient + ', ';
    }
    return out.substring(0, out.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kMealCoverSize / 2),
      padding: EdgeInsets.only(
        top: kMealCoverSize / 2 + kMealBoxPadding,
        left: kMealBoxPadding,
        right: kMealBoxPadding,
        bottom: kMealBoxCornerRadius - kMealBoxPadding,
      ),
      decoration: BoxDecoration(
        color: colorMealBox,
        borderRadius: BorderRadius.all(Radius.circular(kMealBoxCornerRadius)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text(title, style: ktsMealBoxTitle, textAlign: TextAlign.center),
              SizedBox(
                height: kMealBoxPadding,
              ),
              Text(
                ingredientsText(ingredients),
                style: ktsMealBoxDetail,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                portion,
                style: ktsMealBoxPortion,
              ),
              Text(
                price == null ? '' : '\$ ${price.toString()}',
                style: ktsMealBoxPrice,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
