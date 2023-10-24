import '../app_images.dart';

class Item {
  String imgPath;
  double price;
  String location;
  String name;
  Item({
    required this.imgPath,
    required this.price,
    required this.location,
    required this.name,
  });
}

List<Item> items = [
  Item(
      imgPath: Assets.imagesImageeating,
      price: 12.99,
      location: 'Katship shop',
      name: 'product:1'),
  Item(
      imgPath: Assets.imagesImage2eating,
      price: 12.99,
      location: 'Mexico Shop',
      name: 'product:2'),
  Item(
      imgPath:Assets.imagesImage3eating,
      price: 12.99,
      location: 'vulcano Shop',
      name: 'product:3'),
  Item(
      imgPath: Assets.imagesImage4eating,
      price: 12.99,
      location: 'Almanufi shop',
      name: 'product:4'),
  Item(
      imgPath: Assets.imagesImage5eating,
      price: 12.99,
      location: 'Alshabrawy shop',
      name: 'product:5'),
  Item(
      imgPath: Assets.imagesImage6eating,
      price: 12.99,
      location: 'Alzaeim shop',
      name: 'product:6'),
  Item(
      imgPath: Assets.imagesImage7eating,
      price: 12.99,
      location: 'Alasli Shop',
      name: 'product:7'),
  Item(
      imgPath: Assets.imagesImage8eating,
      price: 12.99,
      location: 'Kabak shakir shop',
      name: 'product:8')
];
