/// alphaId : "162761Rail_Food"
/// status : "Delivered"
/// delivery_boy_id : 1
/// orderStatusRemarks : "reason for cancellation"

class OrderSetStatusModel {
  OrderSetStatusModel({
      this.alphaId, 
      this.status, 
      this.deliveryBoyId, 
      this.orderStatusRemarks,});

  OrderSetStatusModel.fromJson(dynamic json) {
    alphaId = json['alphaId'];
    status = json['status'];
    deliveryBoyId = json['delivery_boy_id'];
    orderStatusRemarks = json['orderStatusRemarks'];
  }
  String? alphaId;
  String? status;
  int? deliveryBoyId;
  String? orderStatusRemarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alphaId'] = alphaId;
    map['status'] = status;
    map['delivery_boy_id'] = deliveryBoyId;
    map['orderStatusRemarks'] = orderStatusRemarks;
    return map;
  }

}