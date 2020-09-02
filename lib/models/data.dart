import 'package:chefmenu2/models/meal.dart';
import 'package:chefmenu2/models/meal_category.dart';
import 'menu.dart';

Menu menu = Menu(
  title: 'Demo',
  categories: [
    MealCategory(
      title: 'Hamburgesas',
      meals: [
        Meal(
          title: 'Gallo Pinto',
          imageUrl: 'img/0/0.jpeg',
          ingredients: ['hielo', 'pimiento picante'],
          price: 12.33,
          portion: '240 g',
        ),
        Meal(
          title: 'Gallo Pinto 2 ',
          imageUrl: 'img/0/0.jpeg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
      ],
    ),
    MealCategory(
      title: 'Pescado',
      meals: [
        Meal(
          title: 'Salmon',
          imageUrl: 'img/0/0.jpeg',
          ingredients: ['hielo', 'pimiento picante'],
          price: 12.33,
          portion: '240 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/0/0.jpeg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
      ],
    ),
    MealCategory(
      title: 'Postres',
      meals: [
        Meal(
          title: 'Tiramisu',
          imageUrl: 'img/0/0.jpeg',
          ingredients: ['hielo', 'pimiento picante'],
          price: 12.33,
          portion: '240 g',
        ),
        Meal(
          title: 'Flan',
          imageUrl: 'img/0/0.jpeg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
      ],
    ),
  ],
);
