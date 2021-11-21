import 'package:flutter/foundation.dart';
import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  // catalog field
  CatalogModel _catalog;

  // Collection of IDs - store Ids of each item
  final List<int> _itemIds = [];

  // get catalog
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  // Get item in the cart
  List<Item> get items => _itemIds.map((id) => catalog.getById(id)).toList();

  // get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  // Add item
  // void add(Item item) {
  //   _itemIds.add(item.id);
  // }

  // remove item
  // void remove(Item item) {
  //   _itemIds.remove(item.id);
  // }
}

class AddMutation extends VxMutation<MyStore>{
  final Item item;

  AddMutation(this.item);
  @override
  perform() {
    // TODO: implement perform
    store.cart._itemIds.add(item.id);
  }

}

class RemoveMutation extends VxMutation<MyStore>{
  final Item item;

  RemoveMutation(this.item);
  @override
  perform() {
    // TODO: implement perform
    store.cart._itemIds.remove(item.id);
  }

}
