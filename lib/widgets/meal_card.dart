import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class MealCard extends StatelessWidget {
  final int numberOfColumns;
  final int i;
  MealCard({this.i, this.numberOfColumns});

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
          bottom: kMealCoverSize / 4,
        ),
        decoration: BoxDecoration(
          color: colorBackground,
        ),
        child: Stack(children: [
          MealBox(),
          MealCover(),
        ]),
        //margin: EdgeInsets.all(0),
      ),
    );
  }
}

class MealCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: kMealCoverSize,
        width: kMealCoverSize,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
              fit: BoxFit.cover),
          //color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(kMealCoverCornerRadius)),
        ),
      ),
    );
  }
}

class MealBox extends StatelessWidget {
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
        color: Color(0x00707070).withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(kMealBoxCornerRadius)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text('Good \'ld chicken', style: ktsMealBoxTitle, textAlign: TextAlign.center),
              SizedBox(
                height: kMealBoxPadding,
              ),
              Text(
                'chicken, peppers, mayo, salad',
                style: ktsMealBoxDetail,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '300 g',
                style: ktsMealBoxPortion,
              ),
              Text(
                '\$ 16.00',
                style: ktsMealBoxPrice,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
