/// orderId : 162977736173
/// vendor : ""
/// Customer_name : "test"
/// Contact_number : "8160073298"
/// Delivery_date_Time : "2022-03-05T22:13:13.748Z"
/// status : "Active"
/// Train_Num_Name : "test"
/// Coach_Seat : "test"
/// PNR : "test"
/// orderStatusRemarks : ""
/// remarks : ""
/// isRead : false
/// Order_type : "COD"
/// itemDetails : {"GST":0,"Tax":0,"Discount":0,"Total_cost":360,"Advance_Payment":0,"Delivery_charges":0,"Collectable_amount":360,"items":[{"ItemName":"Paneer butter masala","Qty":3}]}

class AddOrderModel {
  AddOrderModel({
    this.orderId,
    this.vendor,
    this.customerName,
    this.contactNumber,
    this.deliveryDateTime,
    this.status,
    this.trainNumName,
    this.coachSeat,
    this.pnr,
    this.orderStatusRemarks,
    this.remarks,
    this.isRead,
    this.orderType,
    this.itemDetails,
  });

  AddOrderModel.fromJson(dynamic json) {
    orderId = json['orderId'];
    vendor = json['vendor'];
    customerName = json['Customer_name'];
    contactNumber = json['Contact_number'];
    deliveryDateTime = json['Delivery_date_Time'];
    status = json['status'];
    trainNumName = json['Train_Num_Name'];
    coachSeat = json['Coach_Seat'];
    pnr = json['PNR'];
    orderStatusRemarks = json['orderStatusRemarks'];
    remarks = json['remarks'];
    isRead = json['isRead'];
    orderType = json['Order_type'];
    itemDetails = json['itemDetails'] != null
        ? ItemDetails.fromJson(json['itemDetails'])
        : null;
  }

  int? orderId;
  String? vendor;
  String? customerName;
  String? contactNumber;
  String? deliveryDateTime;
  String? status;
  String? trainNumName;
  String? coachSeat;
  String? pnr;
  String? orderStatusRemarks;
  String? remarks;
  bool? isRead;
  String? orderType;
  ItemDetails? itemDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;
    map['vendor'] = vendor;
    map['Customer_name'] = customerName;
    map['Contact_number'] = contactNumber;
    map['Delivery_date_Time'] = deliveryDateTime;
    map['status'] = status;
    map['Train_Num_Name'] = trainNumName;
    map['Coach_Seat'] = coachSeat;
    map['PNR'] = pnr;
    map['orderStatusRemarks'] = orderStatusRemarks;
    map['remarks'] = remarks;
    map['isRead'] = isRead;
    map['Order_type'] = orderType;
    if (itemDetails != null) {
      map['itemDetails'] = itemDetails?.toJson();
    }
    return map;
  }
}

/// GST : 0
/// Tax : 0
/// Discount : 0
/// Total_cost : 360
/// Advance_Payment : 0
/// Delivery_charges : 0
/// Collectable_amount : 360
/// items : [{"ItemName":"Paneer butter masala","Qty":3}]

class ItemDetails {
  ItemDetails({
    this.gst,
    this.tax,
    this.discount,
    this.totalCost,
    this.advancePayment,
    this.deliveryCharges,
    this.collectableAmount,
    this.items,
  });

  ItemDetails.fromJson(dynamic json) {
    gst = json['GST'];
    tax = json['Tax'];
    discount = json['Discount'];
    totalCost = json['Total_cost'];
    advancePayment = json['Advance_Payment'];
    deliveryCharges = json['Delivery_charges'];
    collectableAmount = json['Collectable_amount'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

  toOrderModel() {

  }
  double? gst;
  double? tax;
  double? discount;
  double? totalCost;
  double? advancePayment;
  double? deliveryCharges;
  double? collectableAmount;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['GST'] = gst;
    map['Tax'] = tax;
    map['Discount'] = discount;
    map['Total_cost'] = totalCost;
    map['Advance_Payment'] = advancePayment;
    map['Delivery_charges'] = deliveryCharges;
    map['Collectable_amount'] = collectableAmount;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ItemName : "Paneer butter masala"
/// Qty : 3

class Items {
  Items({
    this.itemName,
    this.qty,
  });

  Items.fromJson(dynamic json) {
    itemName = json['ItemName'];
    qty = json['Qty'];
  }

  String? itemName;
  int? qty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ItemName'] = itemName;
    map['Qty'] = qty;
    return map;
  }
}
