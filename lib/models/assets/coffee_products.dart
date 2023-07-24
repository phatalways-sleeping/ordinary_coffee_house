import 'package:coffee_order_app/models/models.dart';

const espresso = CoffeeProduct(
  name: "Espresso",
  description:
      "A concentrated coffee beverage brewed by forcing hot water under pressure.",
  price: 2.99,
  rewardPoints: 10,
  image: "assets/espresso.jpg",
);

const cappuccino = CoffeeProduct(
  name: "Cappuccino",
  description: "An espresso-based coffee drink that originated in Italy.",
  price: 3.49,
  rewardPoints: 15,
  image: "assets/cappuccino.jpg",
);

const latte = CoffeeProduct(
  name: "Latte",
  description: "A coffee drink made with espresso and steamed milk.",
  price: 3.99,
  rewardPoints: 20,
  image: "assets/latte.jpg",
);

const mocha = CoffeeProduct(
  name: "Mocha",
  description: "A chocolate-flavored variant of a latte.",
  price: 4.49,
  rewardPoints: 25,
  image: "assets/mocha.jpg",
);

const americano = CoffeeProduct(
  name: "Americano",
  description:
      "A style of coffee prepared by brewing espresso with added hot water.",
  price: 2.99,
  rewardPoints: 10,
  image: "assets/americano.jpg",
);

const macchiato = CoffeeProduct(
  name: "Macchiato",
  description: "An espresso coffee drink with a small amount of milk foam.",
  price: 3.49,
  rewardPoints: 15,
  image: "assets/macchiato.jpg",
);

const affogato = CoffeeProduct(
  name: "Affogato",
  description:
      "A coffee-based dessert made by pouring a shot of espresso over a scoop of gelato.",
  price: 4.99,
  rewardPoints: 30,
  image: "assets/affogato.jpg",
);

const icedCoffee = CoffeeProduct(
  name: "Iced Coffee",
  description: "Chilled coffee served with ice cubes.",
  price: 3.99,
  rewardPoints: 20,
  image: "assets/iced_coffee.jpg",
);

const coldBrew = CoffeeProduct(
  name: "Cold Brew",
  description:
      "A coffee brewing method that uses time instead of heat to extract flavors.",
  price: 4.49,
  rewardPoints: 25,
  image: "assets/cold_brew.jpg",
);

const turkishCoffee = CoffeeProduct(
  name: "Turkish Coffee",
  description: "A method of preparing coffee that originated in Turkey.",
  price: 3.99,
  rewardPoints: 20,
  image: "assets/turkish_coffee.jpg",
);

const frenchPress = CoffeeProduct(
  name: "French Press",
  description: "A simple coffee brewing device with a plunger and mesh filter.",
  price: 4.99,
  rewardPoints: 25,
  image: "assets/french_press.jpg",
);

const espressoConPanna = CoffeeProduct(
  name: "Espresso Con Panna",
  description: "Espresso topped with whipped cream.",
  price: 4.49,
  rewardPoints: 25,
  image: "assets/espresso_con_panna.jpg",
);

const espressoMartini = CoffeeProduct(
  name: "Espresso Martini",
  description: "A cocktail made with vodka, coffee liqueur, and espresso.",
  price: 6.49,
  rewardPoints: 40,
  image: "assets/espresso_martini.jpg",
);

const caramelMacchiato = CoffeeProduct(
  name: "Caramel Macchiato",
  description: "A variation of a latte with added caramel syrup.",
  price: 4.99,
  rewardPoints: 30,
  image: "assets/caramel_macchiato.jpg",
);

const flatWhite = CoffeeProduct(
  name: "Flat White",
  description:
      "An espresso-based coffee drink with steamed milk and a velvety texture.",
  price: 3.99,
  rewardPoints: 20,
  image: "assets/flat_white.jpg",
);

const coffeeProducts = [
  espresso,
  cappuccino,
  latte,
  mocha,
  americano,
  macchiato,
  affogato,
  icedCoffee,
  coldBrew,
  turkishCoffee,
  frenchPress,
  espressoConPanna,
  espressoMartini,
  caramelMacchiato,
  flatWhite,
];
