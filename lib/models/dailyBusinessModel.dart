/// TotalOrders : 0
/// TotalAmount : 0
/// OnlineOrders : 0
/// OnlineOrdersTotal : 0
/// CODOrders : 0
/// CODOrdersTotal : 0

class DailyBusinessModel {
  DailyBusinessModel({
    this.totalOrders = 0.0,
    this.totalAmount = 0.0,
    this.onlineOrders = 0.0,
    this.onlineOrdersTotal = 0.0,
    this.cODOrders = 0.0,
    this.cODOrdersTotal = 0.0,
  });

  DailyBusinessModel.fromJson(dynamic json) {
    totalOrders = double.tryParse(json['TotalOrders'].toString());
    totalAmount = double.tryParse(json['TotalAmount'].toString());
    onlineOrders = double.tryParse(json['OnlineOrders'].toString());
    onlineOrdersTotal = double.tryParse(json['OnlineOrdersTotal'].toString());
    cODOrders = double.tryParse(json['CODOrders'].toString());
    cODOrdersTotal = double.tryParse(json['CODOrdersTotal'].toString());
  }

  double? totalOrders;
  double? totalAmount;
  double? onlineOrders;
  double? onlineOrdersTotal;
  double? cODOrders;
  double? cODOrdersTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalOrders'] = totalOrders;
    map['TotalAmount'] = totalAmount;
    map['OnlineOrders'] = onlineOrders;
    map['OnlineOrdersTotal'] = onlineOrdersTotal;
    map['CODOrders'] = cODOrders;
    map['CODOrdersTotal'] = cODOrdersTotal;
    return map;
  }
}
