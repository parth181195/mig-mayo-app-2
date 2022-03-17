import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/models/orderDataCountModel.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_mayo/services/drawer_service.dart';
import 'package:mig_mayo/ui/widgets/chip_widget.dart';
import 'package:mig_mayo/ui/widgets/drawerViewModel.dart';
import 'package:mig_ui/mig_ui.dart';
import 'package:stacked/stacked.dart';

class MigDrawer extends StatefulWidget {
  @override
  _MigDrawerState createState() => _MigDrawerState();
}

class _MigDrawerState extends State<MigDrawer> {
  DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DrawerService _drawerService = locator<DrawerService>();
  TextEditingController _controller = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()) +
          ' - ' +
          DateFormat('dd-MM-yyyy').format(DateTime.now()));

  Future<void> _selectDate(BuildContext context, DrawerViewModel model) async {
    final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        initialDateRange: model.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    setState(() {
      model.selectedDate = picked!;
      _controller.text =
          DateFormat('dd-MM-yyyy').format(model.selectedDate.start) +
              ' - ' +
              DateFormat('dd-MM-yyyy').format(model.selectedDate.end);
    });
    await model.getDailyBusiness();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Total number of orders
  //     : 0
  // Total amount from orders
  //     : ₹ 0
  // Online Orders (0)
  //     : ₹ 0
  // COD Orders (0)
  //     : ₹ 0
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerViewModel>.reactive(
      viewModelBuilder: () => DrawerViewModel(),
      onModelReady: (model) async {
        await model.init();
      },
      builder: (context, model, child) => Drawer(
          child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 30,
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Restaurant Name',
          //     style: heading2Style.copyWith(fontSize: 16),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Daily Business',
              style: heading2Style.copyWith(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                onChanged: (_) {
                  model.notifyListeners();
                },
                onTap: () {
                  _selectDate(context, model);
                },
                controller: _controller,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  labelText: 'Date Range',
                  labelStyle: GoogleFonts.openSans(
                    fontWeight: FontWeight.w300,
                  ),
                  hintText: 'Date Range',
                  hintStyle: GoogleFonts.openSans(
                    fontWeight: FontWeight.w300,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total number of orders',
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Text(
                        model.dailyBusinessData != null
                            ? model.dailyBusinessData.totalOrders.toString()
                            : '0',
                        style: GoogleFonts.openSans(
                            color: migOrderStatusPendingColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total amount',
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Text(
                        '₹${model.dailyBusinessData.totalAmount?.toStringAsFixed(2)!}',
                        style: GoogleFonts.openSans(
                            color: migOrderStatusPendingColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Online Orders (${model.dailyBusinessData.onlineOrders?.toStringAsFixed(0)!})',
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Text(
                        '₹${model.dailyBusinessData.onlineOrdersTotal?.toStringAsFixed(2)!}',
                        style: GoogleFonts.openSans(
                            color: migOrderStatusPendingColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'COD Orders (${model.dailyBusinessData.cODOrders?.toStringAsFixed(0)!})',
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Text(
                        '₹${model.dailyBusinessData.cODOrdersTotal?.toStringAsFixed(2)!}',
                        style: GoogleFonts.openSans(
                            color: migOrderStatusPendingColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Orders',
              style: heading2Style.copyWith(fontSize: 25),
            ),
          ),
          InkWell(
            onTap: () {
              model.drawerService.goToOrderPage(OrderStatus.All);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    'All',
                    style: heading2Style.copyWith(fontSize: 16),
                  ),
                  ChipWidget(
                      // number:
                      //     snapshot.data == null ? 0 : snapshot.data!.all,
                      // status: OrderStatus.All,
                      ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              model.drawerService.goToOrderPage(OrderStatus.Active);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    'Active',
                    style: heading2Style.copyWith(fontSize: 16),
                  ),
                  ChipWidget(
                    // number: snapshot.data == null
                    //     ? 0
                    //     : snapshot.data!.active,
                    status: OrderStatus.Active,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              model.drawerService.goToOrderPage(OrderStatus.Confirmed);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    'Confirmed',
                    style: heading2Style.copyWith(fontSize: 16),
                  ),
                  ChipWidget(
                    // number: snapshot.data == null
                    //     ? 0
                    //     : snapshot.data!.confirmed,
                    status: OrderStatus.Confirmed,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              model.drawerService.goToOrderPage(OrderStatus.Cancelled);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    'Cancelled',
                    style: heading2Style.copyWith(fontSize: 16),
                  ),
                  ChipWidget(
                    // number: snapshot.data == null
                    //     ? 0
                    //     : snapshot.data!.cancelled,
                    status: OrderStatus.Cancelled,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              model.drawerService.goToOrderPage(OrderStatus.Delivered);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    'Delivered',
                    style: heading2Style.copyWith(fontSize: 16),
                  ),
                  ChipWidget(
                    // number: snapshot.data == null
                    //     ? 0
                    //     : snapshot.data!.delivered,
                    status: OrderStatus.Delivered,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              model.drawerService.goToOrderPage(OrderStatus.Undelivered);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    'Undelivered',
                    style: heading2Style.copyWith(fontSize: 16),
                  ),
                  ChipWidget(
                    // number: snapshot.data == null
                    //     ? 0
                    //     : snapshot.data!.unDelivered,
                    status: OrderStatus.Undelivered,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              model.drawerService.goToOrderPage(OrderStatus.Pending);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    'Undelivered',
                    style: heading2Style.copyWith(fontSize: 16),
                  ),
                  ChipWidget(
                    // number: snapshot.data == null
                    //     ? 0
                    //     : snapshot.data!.pending,
                    status: OrderStatus.Pending,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
