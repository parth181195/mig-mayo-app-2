/// id : 1
/// userEmail : "1972vragrawal@gmail.com"
/// itemCategory : "veg"
/// items : [{"id":6,"userEmail":"1972vragrawal@gmail.com","vendorName":"Go_Food","itemCategoryId":"2","itemName":"Paneer butter masala","itemPrice":"120","Veg":true,"itemCategoryName":"test1","quantity":5}]

class MenuModel {
  bool itemsAdded = false;

  MenuModel({
    this.id,
    this.userEmail,
    this.itemCategory,
    this.items = const [],
  });

  bool get isVeg {
    List<MenuItemModel>? hasItem =
        items.where((element) => element.veg == false).toList();
    return hasItem.length == 0;
  }

  MenuModel.fromJson(dynamic json) {
    id = json['id'];
    userEmail = json['userEmail'];
    itemCategory = json['itemCategory'];
    items = [];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(MenuItemModel.fromJson(v));
      });
    } else {
      items = [];
    }
  }

  int? id;
  String? userEmail;
  String? itemCategory;
  late List<MenuItemModel> items;

  List<MenuItemModel> addedModelItems() {
    return items.where((element) => element.quantity! > 0).toList();
  }

  get itemsTotal {
    double itemTotal = 0;
    items.where((element) => element.quantity! > 0).forEach((element) {
      itemTotal =
          itemTotal + (element.quantity! * double.parse(element.itemPrice!));
    });
    return itemTotal;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userEmail'] = userEmail;
    map['itemCategory'] = itemCategory;
    map['items'] = items.map((v) => v.toJson()).toList();
    return map;
  }
}

/// id : 6
/// userEmail : "1972vragrawal@gmail.com"
/// vendorName : "Go_Food"
/// itemCategoryId : "2"
/// itemName : "Paneer butter masala"
/// itemPrice : "120"
/// Veg : true
/// itemCategoryName : "test1"
/// quantity : 5

class MenuItemModel {
  MenuItemModel({
    this.id,
    this.userEmail,
    this.vendorName,
    this.itemCategoryId,
    this.itemName,
    this.itemPrice,
    this.veg,
    this.itemCategoryName,
    this.quantity = 0,
  });

  MenuItemModel.fromJson(dynamic json) {
    id = json['id'];
    userEmail = json['userEmail'];
    vendorName = json['vendorName'];
    itemCategoryId = json['itemCategoryId'];
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    veg = json['Veg'];
    itemCategoryName = json['itemCategoryName'];
    quantity = json['quantity'] ?? 0;
  }

  int? id;
  String? userEmail;
  String? vendorName;
  String? itemCategoryId;
  String? itemName;
  String? itemPrice;
  bool? veg;
  String? itemCategoryName;
  int? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userEmail'] = userEmail;
    map['vendorName'] = vendorName;
    map['itemCategoryId'] = itemCategoryId;
    map['itemName'] = itemName;
    map['itemPrice'] = itemPrice;
    map['Veg'] = veg;
    map['itemCategoryName'] = itemCategoryName;
    map['quantity'] = quantity;
    return map;
  }
}
