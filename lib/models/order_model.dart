import 'package:flutter/cupertino.dart';
import 'package:mig_mayo/models/order_status.dart';

class OrderModel {
  String? alphaId;
  String? userId;
  String? orderId;
  String? vendor;
  String? customerName;
  String? contactNumber;
  DateTime? deliveryDateTime;
  OrderStatus? status;
  String? remarks;
  String? trainNumName;
  String? deliveryExecutiveId;
  String? coachSeat;
  String? pnr;
  String? orderType;
  String? orderStatusRemarks;
  bool? isRead;
  late ItemDetailsModel itemDetails;

  OrderModel(
      {String? alphaId,
      this.userId,
      required this.itemDetails,
      this.orderId,
      this.vendor,
      this.customerName,
      this.contactNumber,
      this.deliveryDateTime,
      this.status,
      this.remarks,
      this.trainNumName,
      this.coachSeat,
      this.pnr,
      this.orderType,
      this.orderStatusRemarks,
      this.deliveryExecutiveId,
      this.isRead});

  OrderModel.fromJson(dynamic json) {
    try {
      alphaId = changeNull(json['alphaId']);
      userId = changeNull(json['userId']);
      orderId = changeNull(json['orderId']);
      vendor = changeNull(json['vendor']);
      customerName = changeNull(json['Customer_name']);
      contactNumber = changeNull(json['Contact_number']);
      deliveryDateTime = DateTime.parse(json['Delivery_date_Time']);
      switch (json['status']) {
        case 'Active':
          status = OrderStatus.Active;
          break;
        case 'Cancelled':
          status = OrderStatus.Cancelled;
          break;
        case 'Delivered':
          status = OrderStatus.Delivered;
          break;
        case 'Pending':
          status = OrderStatus.Pending;
          break;
        case 'Pending':
          status = OrderStatus.Pending;
          break;

        case 'Confirmed':
          status = OrderStatus.Confirmed;
          break;
      }

      remarks = changeNull(json['remarks']);
      trainNumName = changeNull(json['Train_Num_Name']);
      coachSeat = changeNull(json['Coach_Seat']);
      pnr = changeNull(json['PNR']);
      orderType = changeNull(json['Order_type']);
      orderStatusRemarks = changeNull(json['orderStatusRemarks']);
      deliveryExecutiveId = changeNull(json['deliveryExecutiveId']);
      itemDetails = ItemDetailsModel.fromJson(json['itemDetails']);
      isRead = json['isRead'];
    } catch (e) {
      print(e);
    }
  }

  changeNull(data) {
    return data != null ? data : '';
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['alphaId'] = alphaId;
    map['userId'] = userId;
    map['Order_id'] = orderId;
    map['Vendor'] = vendor;
    map['Customer_name'] = customerName;
    map['Contact_number'] = contactNumber;
    map['Delivery_date_Time'] = deliveryDateTime;
    map['status'] = status;
    map['remarks'] = remarks;
    map['Train_Num_Name'] = trainNumName;
    map['Coach_Seat'] = coachSeat;
    map['PNR'] = pnr;
    map['Order_type'] = orderType;
    map['orderStatusRemarks'] = orderStatusRemarks;
    map['isRead'] = isRead;

    return map;
  }
}

class ItemDetailsModel {
  double? GST;
  double? Tax;
  late List<ItemModel> items;
  String? alphaId;
  double? Discount;
  double? Total_cost;
  double? Advance_Payment;
  double? Delivery_charges;
  double? Collectable_amount;

  ItemDetailsModel({
    this.GST,
    this.Tax,
    this.alphaId,
    required this.items,
    this.Discount,
    this.Total_cost,
    this.Advance_Payment,
    this.Delivery_charges,
    this.Collectable_amount,
  });

  ItemDetailsModel.fromJson(dynamic json) {
    items = [];
    if (json['items'] == null) {
      json['items'] = [];
    }
    json['items'].forEach((value) => {items.add(ItemModel.fromJson(value))});
    GST = toDouble(json['GST']);
    Tax = toDouble(json['Tax']);
    alphaId = json['alphaId'];
    Discount = toDouble(json['Discount']);
    Total_cost = toDouble(json['Total_cost']);
    Advance_Payment = toDouble(json['Advance_Payment']);
    Delivery_charges = toDouble(json['Delivery_charges']);

    Collectable_amount = toDouble(json['Collectable_amount']);
  }

  toDouble(dynamic data) {
    try {
      var converted;
      if (data == null || data == 'null') {
        return null;
      }
      if (data is String) {
        converted = double.parse(data);
      } else if (data is int) {
        converted = double.parse(data.toString());
      } else {
        converted = data;
      }
      return converted;
    } catch (e) {
      return 0.0;
    }
  }
}

class ItemModel {
  String? ItemName;
  String? Qty;

  ItemModel({
    this.ItemName,
    this.Qty,
  });

  ItemModel.fromJson(dynamic json) {
    ItemName = json['ItemName'];
    Qty = json['Qty'];
  }
}
