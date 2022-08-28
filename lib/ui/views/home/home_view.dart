import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mig_mayo/models/deliveryExecutiveModel.dart';
import 'package:mig_mayo/models/dropDownModel.dart';
import 'package:mig_mayo/models/orderSetStatusModel.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_mayo/ui/views/home/home_view_model.dart';
import 'package:mig_mayo/ui/widgets/drawer.dart';
import 'package:mig_mayo/ui/widgets/order_card.dart';
import 'package:mig_ui/mig_ui.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(vsync: this, length: 7);
    // showDebugBtn(context, btnColor: Colors.blue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) async {
        await model.init(tabController);
      },
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 25),
            indicatorColor: Colors.black,
            labelColor: Colors.redAccent,

            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle:
                heading2Style.copyWith(color: migBlackColor, fontSize: 12),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),

            // labelColor: migBlackColor,
            tabs: [
              Tab(
                child: Text('All'),
              ),
              Tab(
                child: Text('Active'),
              ),
              Tab(
                child: Text('Confirmed'),
              ),
              Tab(
                child: Text('Canceled'),
              ),
              Tab(
                child: Text('Delivered'),
              ),
              Tab(
                child: Text('UnDelivered'),
              ),
              Tab(
                child: Text('Pending'),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: migWhiteColor,
          elevation: 7,
          iconTheme: IconThemeData(color: migBlackColor),
          title: Text(
            'Orders',
            style: GoogleFonts.openSans(
                color: migBlackColor,
                fontWeight: FontWeight.w100,
                fontSize: 28),
          ),
          actions: [
            if (!model.busy('all'))
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'Total Orders: ${model.orders[model.pages[model.tabController.index]]!.length.toString()}',
                    style: GoogleFonts.openSans(
                        color: migBlackColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 16),
                  ),
                ),
              )
          ],
        ),
        drawer: MigDrawer(),
        body: TabBarView(
          controller: tabController,
          children: model.pages.map(
            (page) {
              return model.busy(page)
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(migBlackColor),
                      ),
                    )
                  : model.orders[page]?.length == 0
                      ? Center(
                          child: Text('No Data'),
                        )
                      : ListView(
                          physics: BouncingScrollPhysics(),
                          children: model.orders[page]!.map(
                            (order) {
                              return OrderCard(
                                onOrderCancel: () async {
                                  await model.setOrderCancel(order);
                                },
                                onStatusChangeBtnClick: () async {
                                  OrderSetStatusModel payload =
                                      OrderSetStatusModel(
                                          alphaId: order.alphaId,
                                          status: model.getStatusText(
                                              order.status!),
                                          orderStatusRemarks:
                                              order.orderStatusRemarks == null
                                                  ? ''
                                                  : order.orderStatusRemarks);
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                            child: StatefulBuilder(
                                              builder:
                                                  (context, setStateModel) =>
                                                      Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5,
                                                    left: 10,
                                                    right: 10,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Text(
                                                        'Change Status',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                color:
                                                                    migBlackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 22),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 10,
                                                      ),
                                                      child:
                                                          DropdownButtonFormField2(
                                                        decoration:
                                                            InputDecoration(
                                                              label: Text('Change Status'),
                                                          //Add isDense true and zero Padding.
                                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          10),
                                                          border: circularBorder
                                                              .copyWith(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    migWhiteColor),
                                                          ),
                                                          errorBorder:
                                                              circularBorder
                                                                  .copyWith(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          focusedBorder:
                                                              circularBorder
                                                                  .copyWith(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    migBlackColor),
                                                          ),
                                                          enabledBorder:
                                                              circularBorder
                                                                  .copyWith(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    migLightGreyColor),
                                                          ),
                                                          //Add more decoration as you want here
                                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                        ),
                                                        buttonWidth:
                                                            double.maxFinite,
                                                        items: model
                                                            .dropdownItemList
                                                            .where((element) {
                                                              return order.status !=
                                                                element.value;
                                                            }).toList()
                                                            .map((DropDownModel
                                                                e) {
                                                          return DropdownMenuItem(
                                                            enabled:
                                                                order.status !=
                                                                    e.value,
                                                            child: Opacity(
                                                                child: Text(
                                                                  e.label,
                                                                ),
                                                                opacity:
                                                                    order.status !=
                                                                            e.value
                                                                        ? 1
                                                                        : 0.5),
                                                            value: e.value,
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          setStateModel(() {
                                                            payload.status = model
                                                                .getStatusText(value
                                                                    as OrderStatus);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    if (model.getStatusEnum(
                                                            payload.status!) !=
                                                        OrderStatus.Delivered)
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: 10,
                                                        ),
                                                        child: TextFormField(
                                                          initialValue: payload
                                                                      .orderStatusRemarks ==
                                                                  null
                                                              ? ''
                                                              : payload
                                                                  .orderStatusRemarks,
                                                          onChanged: (value) {
                                                            setStateModel(() {
                                                              payload.orderStatusRemarks =
                                                                  value;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            filled: true,
                                                            fillColor:
                                                                migWhiteColor,
                                                            labelText:
                                                                'Remarks',
                                                            labelStyle: bodyStyle
                                                                .copyWith(
                                                                    color:
                                                                        migBlackColor),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        20),
                                                            border:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          migWhiteColor),
                                                            ),
                                                            errorBorder:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            focusedBorder:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          migBlackColor),
                                                            ),
                                                            enabledBorder:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          migLightGreyColor),
                                                            ),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          style: bodyStyle.copyWith(
                                                              color:
                                                                  migBlackColor),
                                                          cursorColor:
                                                              migBlackColor,
                                                        ),
                                                      ),
                                                    if ((model.getStatusEnum(
                                                            payload.status!) ==
                                                        OrderStatus.Delivered))
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 10,
                                                        ),
                                                        child:
                                                            DropdownButtonFormField2(
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Select Delivery Executive',
                                                            //Add isDense true and zero Padding.
                                                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                            isDense: true,
                                                            labelStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            12,
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          migWhiteColor),
                                                            ),
                                                            errorBorder:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            focusedBorder:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          migBlackColor),
                                                            ),
                                                            enabledBorder:
                                                                circularBorder
                                                                    .copyWith(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          migLightGreyColor),
                                                            ),
                                                            //Add more decoration as you want here
                                                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                          ),
                                                          buttonWidth:
                                                              double.maxFinite,
                                                          items: model
                                                              .deliveryExecutiveData
                                                              .map(
                                                                  (DeliveryExecutiveModel
                                                                      e) {
                                                            return DropdownMenuItem(
                                                              child: Text(e
                                                                  .deliveryExecutiveName!),
                                                              value: e,
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setStateModel(() {
                                                              payload.deliveryBoyId =
                                                                  (value as DeliveryExecutiveModel)
                                                                      .id;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ElevatedButton(
                                                      onPressed: order.status !=
                                                              model.getStatusEnum(
                                                                  payload
                                                                      .status!)
                                                          ? model.getStatusEnum(
                                                                          payload
                                                                              .status!) ==
                                                                      OrderStatus
                                                                          .Delivered &&
                                                                  payload.deliveryBoyId ==
                                                                      null
                                                              ? null
                                                              : () async {
                                                                  await model
                                                                      .setOrderStatus(
                                                                          order,
                                                                          payload,
                                                                          setStateModel);
                                                                }
                                                          : null,
                                                      child: model
                                                              .busy('setStatus')
                                                          ? CircularProgressIndicator(
                                                              strokeWidth: 1,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      migWhiteColor),
                                                            )
                                                          : Text(
                                                              'Change status'),
                                                      style: getButtonStyle(
                                                              ButtonType.normal,
                                                              5.0)
                                                          .copyWith(
                                                              minimumSize: MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) => Size(
                                                                          double
                                                                              .maxFinite,
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
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15))));
                                },
                                onOrderConfirmed: () async {
                                  await model.setOrderConfirm(order);
                                },
                                onTap: () {
                                  model.goToOrderDetails(order);
                                },
                                orderModel: order,
                              );
                            },
                          ).toList());
              // Center(
              //         child: Text(page),
              //       );
            },
          ).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.goToAddOrder();
          },
          backgroundColor: migWhiteColor,
          child: Icon(
            Icons.add,
            color: migBlackColor,
          ),
        ),
      ),
    );
  }
}
