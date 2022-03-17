/// id : 1
/// restaurantId : "1972vragrawal@gmail.com"
/// deliveryExecutiveName : "test1123"
/// commision : "050"

class DeliveryExecutiveModel {
  DeliveryExecutiveModel({
      this.id, 
      this.restaurantId, 
      this.deliveryExecutiveName, 
      this.commision,});

  DeliveryExecutiveModel.fromJson(dynamic json) {
    id = json['id'];
    restaurantId = json['restaurantId'];
    deliveryExecutiveName = json['deliveryExecutiveName'];
    commision = json['commision'];
  }
  int? id;
  String? restaurantId;
  String? deliveryExecutiveName;
  String? commision;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['restaurantId'] = restaurantId;
    map['deliveryExecutiveName'] = deliveryExecutiveName;
    map['commision'] = commision;
    return map;
  }

}