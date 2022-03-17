import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mig_mayo/models/order_model.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_ui/mig_ui.dart';

class OrderCard extends StatefulWidget {
  final OrderModel orderModel;
  final Function? onTap;
  final Function? onStatusChangeBtnClick;
  final Function? onOrderConfirmed;
  final Function? onOrderCancel;

  const OrderCard({
    Key? key,
    required this.orderModel,
    this.onTap,
    this.onOrderConfirmed,
    this.onOrderCancel,
    this.onStatusChangeBtnClick,
  }) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.Active:
        return 'Active';
      case OrderStatus.Confirmed:
        return 'Confirmed';
      case OrderStatus.Cancelled:
        return 'Cancelled';
      case OrderStatus.Delivered:
        return 'Delivered';
      case OrderStatus.Undelivered:
        return 'UnDelivered';
      case OrderStatus.Pending:
        return 'Pending';
    }
  }

  getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.Active:
        return migOrderStatusActiveColor;
      case OrderStatus.Confirmed:
        return migOrderStatusActiveColor;
      case OrderStatus.Cancelled:
        return migOrderStatusCancelledColor;
      case OrderStatus.Delivered:
        return migOrderStatusDeliveredColor;
      case OrderStatus.Undelivered:
        return migOrderStatusUndeliveredColor;
      case OrderStatus.Pending:
        return migOrderStatusPendingColor;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: migBlackColor.withOpacity(0.2), blurRadius: 20)
            ]),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: migWhiteColor,
          type: MaterialType.card,
          child: InkWell(
            overlayColor:
                MaterialStateProperty.all(migBlackColor.withOpacity(0.02)),
            highlightColor: migBlackColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              widget.onTap!();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Column(
                children: [
                  // title strip
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: migOrderStatusCancelledColor))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.orderModel.orderId!,
                            style: heading1Style.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2.5),
                                  child: Text(widget.orderModel.orderType!,
                                      style: heading1Style.copyWith(
                                          fontSize: 12,
                                          color: migBlackColor,
                                          fontWeight: FontWeight.w200)),
                                ),
                                decoration: BoxDecoration(
                                  color: migWhiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29000000),
                                      blurRadius: 6,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2.5),
                                  child: Text(
                                      getStatusText(
                                          widget.orderModel.status != null
                                              ? widget.orderModel.status!
                                              : OrderStatus.Active),
                                      style: heading1Style.copyWith(
                                          fontSize: 12,
                                          color: migWhiteColor,
                                          fontWeight: FontWeight.w200)),
                                ),
                                decoration: BoxDecoration(
                                    color: getStatusColor(
                                        widget.orderModel.status!),
                                    borderRadius: BorderRadius.circular(2.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x29000000),
                                        blurRadius: 6,
                                      ),
                                    ]),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  // first row of order details
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrderColDetails(
                            data: widget.orderModel.trainNumName,
                            title: 'Train No.'),
                        OrderColDetails(
                          data: widget.orderModel.coachSeat,
                          title: 'Seat No.',
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        OrderColDetails(
                          data: widget.orderModel.vendor,
                          title: 'Vendor',
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                  ),
                  // second row for order details
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 2.5),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrderColDetails(
                            data: widget.orderModel.contactNumber,
                            title: 'Mobile No.'),
                        OrderColDetails(
                          data: widget.orderModel.deliveryDateTime!.day
                              .toString(),
                          title: 'Time',
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        OrderColDetails(
                          data: widget.orderModel.deliveryDateTime!.day
                              .toString(),
                          title: 'Date',
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 2.5),
                    child: widget.orderModel.status == OrderStatus.Active
                        ? Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await widget.onOrderConfirmed!();
                                    },
                                    child: Text('Confirm'),
                                    style: getButtonStyle(
                                            ButtonType.normal, 5.0)
                                        .copyWith(backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (state) {
                                      if (state
                                          .contains(MaterialState.disabled)) {
                                        return migLightGreyColor;
                                      }
                                      return migOrderStatusDeliveredColor;
                                    })),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await widget.onOrderCancel!();
                                  },
                                  child: Text('Cancel'),
                                  style: getButtonStyle(ButtonType.normal, 5.0)
                                      .copyWith(backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (state) {
                                    if (state
                                        .contains(MaterialState.disabled)) {
                                      return migLightGreyColor;
                                    }
                                    return migOrderStatusCancelledColor;
                                  })),
                                ),
                              )
                            ],
                          )
                        : Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      widget.onStatusChangeBtnClick!();
                                    },
                                    child: Text('Change status'),
                                    style:
                                        getButtonStyle(ButtonType.normal, 5.0)
                                            .copyWith(),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Print'),
                                  style: getButtonStyle(ButtonType.normal, 5.0)
                                      .copyWith(),
                                ),
                              )
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderStatusDetails extends StatelessWidget {
  final String title;
  final String data;
  final Color background;
  final CrossAxisAlignment crossAxisAlignment;

  const OrderStatusDetails({
    Key? key,
    required this.title,
    required this.data,
    required this.background,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: heading1Style.copyWith(
                fontSize: 12,
                color: migBlackColor,
                fontWeight: FontWeight.w200),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(3.5),
              ),
              child: Text(
                data,
                style:
                    heading1Style.copyWith(color: migWhiteColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderColDetails extends StatelessWidget {
  const OrderColDetails({
    Key? key,
    required this.data,
    required this.title,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  final dynamic data;
  final String title;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: heading1Style.copyWith(
                fontSize: 12,
                color: migBlackColor,
                fontWeight: FontWeight.w200),
          ),
          Text(
            data!,
            style: heading1Style.copyWith(
                fontSize: 16,
                color: migBlackColor,
                fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }
}
