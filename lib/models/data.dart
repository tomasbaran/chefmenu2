import 'package:chefmenu2/models/meal.dart';
import 'package:chefmenu2/models/meal_category.dart';
import 'menu.dart';

Menu menu = Menu(
  title: 'Demo',
  categories: [
    MealCategory(
      title: 'Menú del día (\$14.99)',
      meals: [
        Meal(
          title: 'Entrante: Bol de nueces',
          imageUrl: 'img/0/0.jpg',
          ingredients: [
            'almendras',
            'cacahuetes',
            'semillas de calabaza',
          ],
          //price: ,
          portion: '50 g',
        ),
        Meal(
          title: 'Sopa A: Plato de mariscos',
          imageUrl: 'img/0/1.jpg',
          ingredients: ['tomate', 'marisco', 'papa', 'zanahoria', 'ajo'],
          //price: ,
          portion: '250 ml',
        ),
        Meal(
          title: 'Sopa B: Gazpacho',
          imageUrl: 'img/0/2.jpg',
          ingredients: ['tomate', 'marisco', 'papa', 'zanahoria', 'ajo'],
          //price: ,
          portion: '250 ml',
        ),
        Meal(
          title: 'Plato Principal A: Fettuccine',
          imageUrl: 'img/0/3.jpg',
          ingredients: ['fettuccine', 'champiñones', 'tomate', 'albahaca', 'aceituna'],
          //price: 1.39,
          portion: '350 g',
        ),
        Meal(
          title: 'Plato Principal B: Ensalada',
          imageUrl: 'img/0/4.jpg',
          ingredients: [
            'lechuga',
            'tomate',
            'rábano',
            'rúcula',
            'vinagre',
            'queso',
          ],
          //price: 12.33,
          portion: '350 g',
        ),
        Meal(
          title: 'Plato Principal C: Pizza',
          imageUrl: 'img/0/5.jpg',
          ingredients: [
            'mozarrela',
            'salsa de tomate',
            'champiñones',
            'aceituna',
          ],
          //price: 1.39,
          portion: '480 g',
        ),
        Meal(
          title: 'Postre: Magdalena amarilla',
          imageUrl: 'img/0/6.jpg',
          ingredients: [
            'harina',
            'mantequilla',
            'leche',
            'azúcar',
            'leche',
            'crema',
          ],
          //price: 12.33,
          portion: '80 g',
        ),
        Meal(
          title: 'Bebida: Jarra de agua',
          imageUrl: 'img/0/7.jpg',
          ingredients: ['agua', 'hielo', 'menta', 'lima'],
          //price: 12.33,
          portion: '1 l',
        ),
      ],
    ),
    MealCategory(
      title: 'Vegano',
      meals: [
        Meal(
          title: 'Salmon',
          imageUrl: 'img/1/0.jpg',
          ingredients: ['hielo', 'pimiento picante'],
          price: 12.33,
          portion: '240 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/1.jpg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/2.jpg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/3.jpg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/4.jpg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/5.jpg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/6.jpg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/7.jpg',
          ingredients: ['hielo 2', 'pimiento picante 2'],
          price: 1.39,
          portion: '340 g',
        ),
        Meal(
          title: 'Dorada',
          imageUrl: 'img/1/8.jpg',
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
