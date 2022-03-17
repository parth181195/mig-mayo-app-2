import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mig_mayo/models/chip_mode.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_ui/mig_ui.dart';

class ChipWidget extends StatefulWidget {
  final OrderStatus status;
  final ChipType chipType;
  final int number;
  final String text;

  const ChipWidget(
      {Key? key,
      this.status = OrderStatus.All,
      this.number = 0,
      this.text = '',
      this.chipType = ChipType.number})
      : super(key: key);

  @override
  _ChipWidgetState createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  Widget getChipText(ChipType chipType) {
    switch (chipType) {
      case ChipType.number:
        return Text(
          widget.number.toString(),
          style: TextStyle(color: migWhiteColor),
        );
      case ChipType.text:
        return Text(
          widget.text,
          style: TextStyle(color: migWhiteColor),
        );
      case ChipType.both:
        return Text(
          widget.number.toString() + widget.text,
          style: TextStyle(color: migWhiteColor),
        );
    }
  }

  getChipBgColor(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.All:
        return migOrderStatusAllColor;
      case OrderStatus.Cancelled:
        return migOrderStatusCancelledColor;
      case OrderStatus.Delivered:
        return migOrderStatusDeliveredColor;
      case OrderStatus.Active:
        return migOrderStatusActiveColor;
      case OrderStatus.Confirmed:
        return migOrderStatusActiveColor;
      case OrderStatus.Pending:
        return migOrderStatusPendingColor;
      case OrderStatus.Undelivered:
        return migOrderStatusUndeliveredColor;
    }
  }

  getChipTextColor(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.All:
        return migWhiteColor;
      case OrderStatus.Cancelled:
        return migWhiteColor;
      case OrderStatus.Delivered:
        return migWhiteColor;
      case OrderStatus.Pending:
        return migWhiteColor;
      case OrderStatus.Undelivered:
        return migWhiteColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      constraints: BoxConstraints(minWidth: 10, minHeight: 10),
      decoration: BoxDecoration(
          color: getChipBgColor(widget.status),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
