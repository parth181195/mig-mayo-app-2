import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mig_mayo/models/deliveryExecutiveModel.dart';
import 'package:mig_mayo/models/dropDownModel.dart';
import 'package:mig_mayo/models/orderSetStatusModel.dart';
import 'package:mig_mayo/models/order_model.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_mayo/ui/views/orders/orders_view_model.dart';
import 'package:mig_mayo/utils/utils.dart';
import 'package:mig_ui/mig_ui.dart';
import 'package:stacked/stacked.dart';

class OrdersView extends StatefulWidget {
  OrderModel order;

  OrdersView({
    Key? key,
    required this.order,
  }) : super(key: key) {}

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  getStatusText(OrderStatus status) {
    if (status == null) {
      return '';
    }
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
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrdersViewModel>.reactive(
      viewModelBuilder: () => OrdersViewModel(),
      onModelReady: (model) async {
        await model.onInit();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: migWhiteColor,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
            widget.order.orderId!,
            textAlign: TextAlign.start,
            style: GoogleFonts.openSans(
                color: migBlackColor,
                fontWeight: FontWeight.w100,
                fontSize: 23),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      height: 18,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        widget.order.orderType!,
                        style: GoogleFonts.openSans(
                            color: migBlackColor, fontWeight: FontWeight.w100),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x29000000),
                              blurRadius: 6,
                            ),
                          ],
                          color: migWhiteColor),
                    ),
                  ),
                  Container(
                    height: 18,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      getStatusText(widget.order.status!),
                      style: GoogleFonts.openSans(
                          color: migWhiteColor, fontWeight: FontWeight.w400),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            blurRadius: 6,
                          ),
                        ],
                        color: getStatusColor(widget.order.status!)),
                  ),
                ],
              ),
            ),
          ],
          elevation: 4,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 20),
                      child: Text(
                        'Order Details',
                        style: GoogleFonts.openSans(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Train No',
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                widget.order.trainNumName!,
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seat No',
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                widget.order.coachSeat!,
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Vendor',
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                widget.order.vendor!,
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mobile No.',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              widget.order.contactNumber!,
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Time',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              DateFormat.jm()
                                  .format(widget.order.deliveryDateTime!),
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Date',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              DateFormat.yMd()
                                  .format(widget.order.deliveryDateTime!),
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 20),
                      child: Text(
                        'Items',
                        style: GoogleFonts.openSans(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Item',
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    'Quantity',
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ...widget.order.itemDetails.items.map(
                          (e) => Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              migBlackColor.withOpacity(0.2)))),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.ItemName!,
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      e.Qty!,
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                      child: Text(
                        'Remarks',
                        style: GoogleFonts.openSans(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 20),
                      child: Text(
                        widget.order.remarks!,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x36000000),
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Text(
                          'Price BreakDown',
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total / Sub Total : ₹ ${widget.order.itemDetails.Total_cost}',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Delivery Charge: ₹ ${widget.order.itemDetails.Delivery_charges}',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GST: ₹ ${widget.order.itemDetails.GST}',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Tax: ₹ ${widget.order.itemDetails.Tax}',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount: ₹ ${widget.order.itemDetails.Discount}',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Advance :  ₹ ${widget.order.itemDetails.Advance_Payment}',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 20, 5, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Amount To be Collected',
                                  style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Text(
                                  '₹ ${widget.order.itemDetails.Collectable_amount}',
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      widget.order.status == OrderStatus.Active
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
                                        await model
                                            .setOrderConfirm(widget.order);
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
                                      await model.setOrderCancel(widget.order);
                                    },
                                    child: Text('Cancel'),
                                    style: getButtonStyle(
                                            ButtonType.normal, 5.0)
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
                                        OrderSetStatusModel payload =
                                            OrderSetStatusModel(
                                                alphaId: widget.order.alphaId,
                                                status: model.getStatusText(
                                                    widget.order.status!),
                                                orderStatusRemarks: widget.order
                                                            .orderStatusRemarks ==
                                                        null
                                                    ? ''
                                                    : widget.order
                                                        .orderStatusRemarks);
                                        showModalBottomSheet(
                                            context: context,
                                            builder:
                                                (context) =>
                                                    SingleChildScrollView(
                                                      child: StatefulBuilder(
                                                        builder: (context,
                                                                setStateModel) =>
                                                            Padding(
                                                          padding: EdgeInsets.only(
                                                              top: 5,
                                                              left: 10,
                                                              right: 10,
                                                              bottom: MediaQuery
                                                                      .of(context)
                                                                  .viewInsets
                                                                  .bottom),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10),
                                                                child: Text(
                                                                  'Change Status',
                                                                  style: GoogleFonts.openSans(
                                                                      color:
                                                                          migBlackColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w100,
                                                                      fontSize:
                                                                          22),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical: 10,
                                                                ),
                                                                child:
                                                                    DropdownButtonFormField2(
                                                                  decoration:
                                                                      InputDecoration(
                                                                        label: Text('Change Status'),
                                                                    //Add isDense true and zero Padding.
                                                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                    isDense:
                                                                        true,
                                                                    contentPadding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            12,
                                                                        horizontal:
                                                                            10),
                                                                    border: circularBorder
                                                                        .copyWith(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: migWhiteColor),
                                                                    ),
                                                                    errorBorder:
                                                                        circularBorder
                                                                            .copyWith(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Colors.red),
                                                                    ),
                                                                    focusedBorder:
                                                                        circularBorder
                                                                            .copyWith(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: migBlackColor),
                                                                    ),
                                                                    enabledBorder:
                                                                        circularBorder
                                                                            .copyWith(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: migLightGreyColor),
                                                                    ),
                                                                    //Add more decoration as you want here
                                                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                  ),
                                                                  buttonWidth:
                                                                      double
                                                                          .maxFinite,
                                                                  items: model
                                                                      .dropdownItemList
                                                                      .where(
                                                                          (element) {
                                                                        return widget.order.status !=
                                                                            element.value;
                                                                      })
                                                                      .toList()
                                                                      .map((DropDownModel
                                                                          e) {
                                                                        return DropdownMenuItem(
                                                                          enabled:
                                                                              widget.order.status != e.value,
                                                                          child: Opacity(
                                                                              child: Text(
                                                                                e.label,
                                                                              ),
                                                                              opacity: widget.order.status != e.value ? 1 : 0.5),
                                                                          value:
                                                                              e.value,
                                                                        );
                                                                      })
                                                                      .toList(),
                                                                  onChanged:
                                                                      (value) {
                                                                    setStateModel(
                                                                        () {
                                                                      payload.status =
                                                                          model.getStatusText(value
                                                                              as OrderStatus);
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              if (model.getStatusEnum(
                                                                      payload
                                                                          .status!) !=
                                                                  OrderStatus
                                                                      .Delivered)
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    initialValue: payload.orderStatusRemarks ==
                                                                            null
                                                                        ? ''
                                                                        : payload
                                                                            .orderStatusRemarks,
                                                                    onChanged:
                                                                        (value) {
                                                                      setStateModel(
                                                                          () {
                                                                        payload.orderStatusRemarks =
                                                                            value;
                                                                      });
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          migWhiteColor,
                                                                      labelText:
                                                                          'Remarks',
                                                                      labelStyle:
                                                                          bodyStyle.copyWith(
                                                                              color: migBlackColor),
                                                                      contentPadding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15,
                                                                          horizontal:
                                                                              20),
                                                                      border: circularBorder
                                                                          .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: migWhiteColor),
                                                                      ),
                                                                      errorBorder:
                                                                          circularBorder
                                                                              .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.red),
                                                                      ),
                                                                      focusedBorder:
                                                                          circularBorder
                                                                              .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: migBlackColor),
                                                                      ),
                                                                      enabledBorder:
                                                                          circularBorder
                                                                              .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: migLightGreyColor),
                                                                      ),
                                                                    ),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .emailAddress,
                                                                    style: bodyStyle
                                                                        .copyWith(
                                                                            color:
                                                                                migBlackColor),
                                                                    cursorColor:
                                                                        migBlackColor,
                                                                  ),
                                                                ),
                                                              if ((model.getStatusEnum(
                                                                      payload
                                                                          .status!) ==
                                                                  OrderStatus
                                                                      .Delivered))
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                                  child:
                                                                      DropdownButtonFormField2(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Select Delivery Executive',
                                                                      //Add isDense true and zero Padding.
                                                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                      isDense:
                                                                          true,
                                                                      labelStyle:
                                                                          TextStyle(
                                                                              color: Colors.black),
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              12,
                                                                          horizontal:
                                                                              10),
                                                                      border: circularBorder
                                                                          .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: migWhiteColor),
                                                                      ),
                                                                      errorBorder:
                                                                          circularBorder
                                                                              .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.red),
                                                                      ),
                                                                      focusedBorder:
                                                                          circularBorder
                                                                              .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: migBlackColor),
                                                                      ),
                                                                      enabledBorder:
                                                                          circularBorder
                                                                              .copyWith(
                                                                        borderSide:
                                                                            BorderSide(color: migLightGreyColor),
                                                                      ),
                                                                      //Add more decoration as you want here
                                                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                    ),
                                                                    buttonWidth:
                                                                        double
                                                                            .maxFinite,
                                                                    items: model
                                                                        .deliveryExecutiveData
                                                                        .map((DeliveryExecutiveModel
                                                                            e) {
                                                                      return DropdownMenuItem(
                                                                        child: Text(
                                                                            e.deliveryExecutiveName!),
                                                                        value:
                                                                            e,
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (value) {
                                                                      setStateModel(
                                                                          () {
                                                                        payload
                                                                            .deliveryBoyId = (value
                                                                                as DeliveryExecutiveModel)
                                                                            .id;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ElevatedButton(
                                                                onPressed: widget
                                                                            .order
                                                                            .status !=
                                                                        model.getStatusEnum(payload
                                                                            .status!)
                                                                    ? model.getStatusEnum(payload.status!) == OrderStatus.Delivered &&
                                                                            payload.deliveryBoyId ==
                                                                                null
                                                                        ? null
                                                                        : () async {
                                                                            await model.setOrderStatus(
                                                                                widget.order,
                                                                                payload,
                                                                                setStateModel);
                                                                          }
                                                                    : null,
                                                                child: model.busy(
                                                                        'setStatus')
                                                                    ? CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            1,
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(migWhiteColor),
                                                                      )
                                                                    : Text(
                                                                        'Change status'),
                                                                style: getButtonStyle(
                                                                        ButtonType
                                                                            .normal,
                                                                        5.0)
                                                                    .copyWith(
                                                                        minimumSize: MaterialStateProperty.resolveWith((states) => Size(
                                                                            double.maxFinite,
                                                                            40))),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            elevation: 5,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15))));
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
                                    style:
                                        getButtonStyle(ButtonType.normal, 5.0)
                                            .copyWith(),
                                  ),
                                )
                              ],
                            ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     ElevatedButton(
                      //       onPressed: () async {},
                      //       child: Text('Change status'),
                      //       // viewModel.busy('login')
                      //       //     ? SizedBox(
                      //       //         width: 30,
                      //       //         height: 30,
                      //       //         child: Padding(
                      //       //           padding: const EdgeInsets.all(8.0),
                      //       //           child: CircularProgressIndicator(
                      //       //             strokeWidth: 1,
                      //       //             valueColor: AlwaysStoppedAnimation<Color>(migWhiteColor),
                      //       //           ),
                      //       //         ),
                      //       //       )
                      //       //     :
                      //       style: getButtonStyle(ButtonType.normal, 5.0)
                      //           .copyWith(
                      //               minimumSize:
                      //                   MaterialStateProperty.resolveWith(
                      //                       (state) => Size(140, 35))),
                      //     ),
                      //     ElevatedButton(
                      //       onPressed: () async {},
                      //       child: Text('Print'),
                      //       // viewModel.busy('login')
                      //       //     ? SizedBox(
                      //       //         width: 30,
                      //       //         height: 30,
                      //       //         child: Padding(
                      //       //           padding: const EdgeInsets.all(8.0),
                      //       //           child: CircularProgressIndicator(
                      //       //             strokeWidth: 1,
                      //       //             valueColor: AlwaysStoppedAnimation<Color>(migWhiteColor),
                      //       //           ),
                      //       //         ),
                      //       //       )
                      //       //     :
                      //       style: getButtonStyle(ButtonType.normal, 5.0)
                      //           .copyWith(
                      //               minimumSize:
                      //                   MaterialStateProperty.resolveWith(
                      //                       (state) => Size(140, 35))),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
