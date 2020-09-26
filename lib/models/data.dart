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
      title: 'Desayuno',
      meals: [
        Meal(
          title: 'Huevo a la plancha',
          imageUrl: 'img/5/0.jpg',
          ingredients: [
            'huevo',
            'bacon',
            'aguacate',
            'brócoli',
          ],
          price: 4.99,
          portion: '150 g',
        ),
        Meal(
          title: 'Tostada de verano',
          imageUrl: 'img/5/1.jpg',
          ingredients: ['pan', 'frutas de verano'],
          price: 3.99,
          portion: '70 g',
        ),
        Meal(
          title: 'Cereales',
          imageUrl: 'img/5/2.jpg',
          ingredients: ['papilla', 'avena', 'platano', 'granada', 'mango'],
          price: 4.99,
          portion: '280 g',
        ),
        Meal(
          title: 'Mini tostadas',
          imageUrl: 'img/5/3.jpg',
          ingredients: ['pan', 'arándanos', 'plátano', 'miel'],
          price: 4.99,
          portion: '120 g',
        ),
        Meal(
          title: 'Mini crepes',
          imageUrl: 'img/5/4.jpg',
          ingredients: ['crepes', 'sirope de arce', 'mantequilla'],
          price: 4.99,
          portion: '340 g',
        ),
      ],
    ),
    MealCategory(
      title: 'Vegano',
      meals: [
        Meal(
          title: 'Sopa de fresa',
          imageUrl: 'img/1/0.jpg',
          ingredients: [
            'agua',
            'fresa',
            'sal',
            'azúcar',
          ],
          price: 7.99,
          portion: '250 ml',
        ),
        Meal(
          title: 'Tostadas de colores',
          imageUrl: 'img/1/1.jpg',
          ingredients: [
            'pan',
            'plátano',
            'arándanos',
            'nueces',
            'semillas de calabaza',
            'aguacate',
            'tomates',
          ],
          price: 4.99,
          portion: '250 g',
        ),
        Meal(
          title: 'Ensalada verde',
          imageUrl: 'img/1/2.jpg',
          ingredients: ['lechuga', 'aguacate', 'Tofu', 'cebolla', 'nueces'],
          price: 9.99,
          portion: '450 g',
        ),
        Meal(
          title: 'Ensalada de colores',
          imageUrl: 'img/1/3.jpg',
          ingredients: ['lechuga', 'pimiento', 'pimiento', 'aguacate', 'zanahoria', 'col', 'garbanzos'],
          price: 9.99,
          portion: '450 g',
        ),
        Meal(
          title: 'Tacos veganos',
          imageUrl: 'img/1/4.jpg',
          ingredients: [
            'tortilla',
            'aguacate',
            'maíz',
            'limón',
          ],
          price: 9.99,
          portion: '350 g',
        ),
        Meal(
          title: 'Pizza vegana',
          imageUrl: 'img/1/5.jpg',
          ingredients: ['harina', 'albahaca', 'setas'],
          price: 12.99,
          portion: '450 g',
        ),
      ],
    ),
    MealCategory(
      title: 'Carne',
      meals: [
        Meal(
          title: 'Solomillo con verduras',
          imageUrl: 'img/2/0.jpg',
          ingredients: ['solomillo de cerdo', 'apio', 'salsa'],
          price: 24.99,
          portion: '150 g',
        ),
        Meal(
          title: 'Filete de ternera',
          imageUrl: 'img/2/1.jpg',
          ingredients: [
            'ternera',
            'huevo',
            'remolacha',
            'zanahoria',
            'queso',
            'salsa',
          ],
          price: 24.99,
          portion: '150 g',
        ),
        Meal(
          title: 'Costillas de cordero',
          imageUrl: 'img/2/2.jpg',
          ingredients: ['cordero', 'puré de papas', 'setas'],
          price: 24.99,
          portion: '150 g',
        ),
        Meal(
          title: 'Pavo asado',
          imageUrl: 'img/2/3.jpg',
          ingredients: ['pavo', 'espárrago', 'romero', 'maíz', 'tomate', 'zanahoria', 'guisantes'],
          price: 24.99,
          portion: '150 g',
        ),
        Meal(
          title: 'Barbacoa',
          imageUrl: 'img/2/4.jpg',
          ingredients: ['costillas de cerdo', 'tomates', 'pepinillos', 'papas fritas', 'BBQ salsa', ''],
          price: 24.99,
          portion: '150 g',
        ),
        Meal(
          title: 'Pollo crujiente',
          imageUrl: 'img/2/5.jpg',
          ingredients: ['pechuga de pollo', 'rúcula', 'salsa'],
          price: 19.99,
          portion: '100 g',
        ),
        Meal(
          title: 'Tacos',
          imageUrl: 'img/2/6.jpg',
          ingredients: ['tortilla', 'ternera', 'lechuga', 'salsa'],
          price: 19.99,
          portion: '100 g',
        ),
        Meal(
          title: 'Hamburguesa',
          imageUrl: 'img/2/7.jpg',
          ingredients: ['carne de ternera', 'queso', 'tomate', 'lechuga', 'cebolla', 'papas fritas'],
          price: 9.99,
          portion: '100 g',
        ),
        Meal(
          title: 'Perrito caliente',
          imageUrl: 'img/2/8.jpg',
          ingredients: ['salchicha', 'habichuelas', 'cebolla crujiente', 'lechuga', 'pepinillo', 'mostaza', 'ketchup'],
          price: 9.99,
          portion: '100 g',
        ),
        Meal(
          title: 'Pizza Hawaii',
          imageUrl: 'img/2/9.jpg',
          ingredients: ['salsa de tomate', 'jamón', 'queso', 'piña', 'cebolla', 'cilantro'],
          price: 12.99,
          portion: '450 g',
        ),
      ],
    ),
    MealCategory(
      title: 'Postres',
      meals: [
        Meal(
          title: 'Brownie con helado',
          imageUrl: 'img/3/0.jpg',
          ingredients: ['brownie', 'helado', 'caramelo'],
          price: 9.99,
          portion: '80 g',
        ),
        Meal(
          title: 'Sorpresa de verano',
          imageUrl: 'img/3/1.jpg',
          ingredients: [
            'sandía',
            'fresas',
            'kiwi',
            'arándanos',
            'maracuyá',
            'coco',
          ],
          price: 7.99,
          portion: '80 g',
        ),
        Meal(
          title: 'Crepe',
          imageUrl: 'img/3/2.jpg',
          ingredients: [
            'crepe',
            'fresas',
            'plátano',
            'Nutella',
          ],
          price: 7.99,
          portion: '160 g',
        ),
        Meal(
          title: 'Sueño de chocolate',
          imageUrl: 'img/3/3.jpg',
          ingredients: ['chocolate', 'coco', ''],
          price: 5.99,
          portion: '80 g',
        ),
        Meal(
          title: 'Copa de Oreo',
          imageUrl: 'img/3/4.jpg',
          ingredients: ['chocolate', 'natilla', 'Oreo', 'nata', 'helado'],
          price: 9.99,
          portion: '200 ml',
        ),
        Meal(
          title: 'Postre de frambuesa',
          imageUrl: 'img/3/5.jpg',
          ingredients: ['frambuesas', 'nata', 'caramelo'],
          price: 5.99,
          portion: '80 ml',
        ),
        Meal(
          title: 'Tarta de queso y chocolate',
          imageUrl: 'img/3/6.jpg',
          ingredients: ['queso', 'cacao', 'azúcar'],
          price: 7.99,
          portion: '80 g',
        ),
        Meal(
          title: 'Cookies',
          imageUrl: 'img/3/7.jpg',
          ingredients: ['pepitas de chocolate'],
          price: 4.99,
          portion: '80 g',
        ),
        Meal(
          title: 'Tarta de chocolate',
          imageUrl: 'img/3/8.jpg',
          ingredients: ['chocolate', 'frambuesas', 'arándanos'],
          price: 24.99,
          portion: '500 g',
        ),
      ],
    ),
    MealCategory(
      title: 'Bebidas',
      meals: [
        Meal(
          title: 'Zumo de granada',
          imageUrl: 'img/4/0.jpg',
          ingredients: [''],
          price: 4.99,
          portion: '200 ml',
        ),
        Meal(
          title: 'Detox verde',
          imageUrl: 'img/4/1.jpg',
          ingredients: [''],
          price: 7.99,
          portion: '400 ml',
        ),
        Meal(
          title: 'Limonada',
          imageUrl: 'img/4/2.jpg',
          ingredients: [''],
          price: 4.99,
          portion: '300 ml',
        ),
        Meal(
          title: 'Té rojo',
          imageUrl: 'img/4/3.jpg',
          ingredients: [''],
          price: 5.99,
          portion: '300 ml',
        ),
        Meal(
          title: 'Ice Coffee',
          imageUrl: 'img/4/4.jpg',
          ingredients: [''],
          price: 5.99,
          portion: '300 ml',
        ),
        Meal(
          title: 'Espresso',
          imageUrl: 'img/4/5.jpg',
          ingredients: [''],
          price: 4.99,
          portion: '200 ml',
        ),
        Meal(
          title: 'Cerveza',
          imageUrl: 'img/4/6.jpg',
          ingredients: [''],
          price: 4.99,
          portion: '400 ml',
        ),
        Meal(
          title: 'Vino',
          imageUrl: 'img/4/7.jpg',
          ingredients: [''],
          price: 9.99,
          portion: '250 ml',
        ),
      ],
    ),
  ],
);
