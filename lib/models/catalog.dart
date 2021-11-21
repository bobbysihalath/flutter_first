import 'dart:convert';

class CatalogModel {

  static final catModel = CatalogModel._internal();

  CatalogModel._internal();

  factory CatalogModel() => catModel;

  static List<Item> items;

  // Get item by Id
  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  // Get item by position
  Item getByPosition(int pos) => items[pos];
}

class Item {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item({this.id, this.name, this.desc, this.price, this.color, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'desc': this.desc,
      'price': this.price,
      'color': this.color,
      'image': this.image,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as num,
      color: map['color'] as String,
      image: map['image'] as String,
    );
  }
// after get load data from JSON and Map
// factory Item.fromMap(Map<String, dynamic> map) {
//   return Item(
//       id: map["id"],
//       name: map["name"],
//       desc: map["desc"],
//       price: map["price"],
//       color: map["color"],
//       image: map["image"],
//   );
// }
//
// toMap() =>{
//   "id":id,
//   "name":name,
//   "desc":desc,
//   "price":price,
//   "color":color,
//   "image":image,
// };
}
