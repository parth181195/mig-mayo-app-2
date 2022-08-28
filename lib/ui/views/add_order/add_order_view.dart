import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mig_mayo/models/menuItemModel.dart';
import 'package:mig_mayo/ui/views/add_order/add_order_view_model.dart';
import 'package:mig_mayo/ui/widgets/radio_group.dart';
import 'package:mig_ui/mig_ui.dart';
import 'package:stacked/stacked.dart';

class AddOrderView extends StatefulWidget {
  @override
  _AddOrderViewState createState() => _AddOrderViewState();
}

class _AddOrderViewState extends State<AddOrderView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(5),
  );
  OutlineInputBorder disabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black.withOpacity(0.3),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(5),
  );
  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(5),
  );
  OutlineInputBorder focusedErrorBorder = circularBorder.copyWith(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.red));
  OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(5),
  );

  Future<void> _selectDate(
      BuildContext context, AddOrderViewModel model) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: model.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != model.selectedDate)
      setState(() {
        model.selectedDate = picked;
        model.notifyListeners();
        selectTime(context, model);
      });
  }

  selectTime(BuildContext context, AddOrderViewModel model) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(model.selectedDate));
    if (picked != null && picked != model.selectedDate)
      setState(() {
        model.selectedDate = DateTime(
            model.selectedDate.year,
            model.selectedDate.month,
            model.selectedDate.day,
            picked.hour,
            picked.minute);
        model.orderFormData.deliveryDateTime.text =
            model.selectedDate.toUtc().toIso8601String();
        // model.selectedDate = picked;
        // model.notifyListeners();
      });
  }

  getScaffoldTitle(int stpe) {
    switch (stpe) {
      case 1:
        return 'Add Order Details';
      case 2:
        return 'Add Menu Items';
      default:
        return 'Add Order';
    }
  }

  getMenuItemTile(model, MenuItemModel selectedItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            width: 2,
                            color: Color(selectedItem.veg ?? true
                                ? 0xff40cf6b
                                : 0xffde2740))),
                    padding: EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(selectedItem.veg ?? true
                              ? 0xff40cf6b
                              : 0xffde2740)),
                      height: 16,
                      width: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      selectedItem.itemName!.toString(),
                      style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    '₹' + selectedItem.itemPrice!,
                    style: GoogleFonts.openSans(
                        color: migBlackColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'X',
                    style: GoogleFonts.openSans(
                        color: migBlackColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    (selectedItem.quantity ?? 0).toString(),
                    style: GoogleFonts.openSans(
                        color: migBlackColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 16),
                  ),
                ),
              ])
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  selectedItem.quantity = selectedItem.quantity! + 1;
                  model.notifyListeners();
                },
                child: Text('+'),
                style: getButtonStyle(ButtonType.normal, 5.0).copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith((state) {
                  if (state.contains(MaterialState.disabled)) {
                    return migLightGreyColor;
                  }
                  return migOrderStatusDeliveredColor;
                })),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedItem.quantity! > 0) {
                      selectedItem.quantity = selectedItem.quantity! - 1;
                      if (selectedItem.quantity == 0) {}
                      model.notifyListeners();
                    }
                  },
                  child: Text('-'),
                  style: getButtonStyle(ButtonType.normal, 5.0).copyWith(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((state) {
                    if (state.contains(MaterialState.disabled)) {
                      return migLightGreyColor;
                    }
                    return migOrderStatusCancelledColor;
                  })),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeDateFormatting();
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddOrderViewModel>.reactive(
      viewModelBuilder: () => AddOrderViewModel(),
      onModelReady: (m) async {
        await m.init();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: migWhiteColor,
          elevation: 7,
          iconTheme: IconThemeData(color: migBlackColor),
          title: Text(
            getScaffoldTitle(model.step),
            style: GoogleFonts.openSans(
                color: migBlackColor,
                fontWeight: FontWeight.w100,
                fontSize: 28),
          ),
        ),
        body: model.busy('loading')
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  valueColor: AlwaysStoppedAnimation<Color>(migBlackColor),
                ),
              )
            : Form(
                autovalidateMode: model.orderFormData.submitted
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                key: model.orderFormData.formStateKey,
                child: ListView(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: TextFormField(
                        autovalidateMode: model.orderFormData.submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        obscureText: false,
                        enabled: false,
                        controller: model.orderFormData.orderId,
                        validator: model.orderFormData.orderIdValidator,
                        decoration: InputDecoration(
                          labelText: 'Order Id',
                          labelStyle: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'Order Id',
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: enabledBorder,
                          disabledBorder: disabledBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: focusedErrorBorder,
                          focusedBorder: focusedBorder,
                        ),
                        style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: DropdownButtonFormField2(
                        validator: model.orderFormData.vendorValidator,
                        decoration: InputDecoration(
                          labelText: 'Select Vendor',
                          labelStyle: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 11),
                          border: circularBorder.copyWith(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: migBlackColor),
                          ),
                          enabledBorder: enabledBorder,
                          disabledBorder: disabledBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: focusedErrorBorder,
                          focusedBorder: focusedBorder,
                        ),
                        onChanged: (dynamic v) {
                          model.orderFormData.vendor.text = v.toString();
                        },
                        buttonWidth: double.maxFinite,
                        items: model.vendorData.map((e) {
                          return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                              ));
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        obscureText: false,
                        controller: model.orderFormData.trainNumName,
                        validator: model.orderFormData.trainNumNameValidator,
                        decoration: InputDecoration(
                          labelText: 'Train Number & Name',
                          labelStyle: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'Train Number & Name',
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: enabledBorder,
                          disabledBorder: disabledBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: focusedErrorBorder,
                          focusedBorder: focusedBorder,
                        ),
                        style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        controller: model.orderFormData.coachSeat,
                        validator: model.orderFormData.coachSeatValidator,
                        autovalidateMode: model.orderFormData.submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Coach & Seat Number',
                          labelStyle: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'Coach & Seat Number',
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: enabledBorder,
                          disabledBorder: disabledBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: focusedErrorBorder,
                          focusedBorder: focusedBorder,
                        ),
                        style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        autovalidateMode: model.orderFormData.submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        obscureText: false,
                        controller: model.orderFormData.customerName,
                        validator: model.orderFormData.customerNameValidator,
                        decoration: InputDecoration(
                          labelText: 'Customer Name',
                          labelStyle: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'Customer Name',
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: enabledBorder,
                          disabledBorder: disabledBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: focusedErrorBorder,
                          focusedBorder: focusedBorder,
                        ),
                        style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        autovalidateMode: model.orderFormData.submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        obscureText: false,
                        controller: model.orderFormData.pnr,
                        validator: model.orderFormData.pnrValidator,
                        decoration: InputDecoration(
                          labelText: 'PNR Number',
                          labelStyle: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'PNR Number',
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: enabledBorder,
                          disabledBorder: disabledBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: focusedErrorBorder,
                          focusedBorder: focusedBorder,
                        ),
                        style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        autovalidateMode: model.orderFormData.submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        controller: model.orderFormData.contactNumber,
                        validator: model.orderFormData.contactNumberValidator,
                        decoration: InputDecoration(
                          labelText: 'Mobile No.',
                          labelStyle: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'Mobile No.',
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: enabledBorder,
                          disabledBorder: disabledBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: focusedErrorBorder,
                          focusedBorder: focusedBorder,
                        ),
                        style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    DateTimePicker(
                      type: DateTimePickerType.dateTimeSeparate,
                      dateMask: 'd MMM, yyyy',
                      use24HourFormat: false,
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime.now(),
                      initialTime:  TimeOfDay.fromDateTime(DateTime.now()),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      timeLabelText: "Hour",
                      locale: Localizations.localeOf(context),
                      onChanged: (val) {
                        model.orderFormData.deliveryDateTime.text = val;
                        print(model.orderFormData.deliveryDateTime.text);
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                    RadioGroup(
                        label: 'Payment Type',
                        list: [
                          RadioList(name: 'COD', index: 1, value: 'COD'),
                          RadioList(name: 'ONLINE', index: 2, value: 'ONLINE'),
                        ],
                        onSelect: (val) {
                          model.orderFormData.paymentType = val;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Menu Items',
                        style: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                      child: TextFormField(
                        autovalidateMode: model.orderFormData.submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        obscureText: false,
                        controller: model.searchController,
                        onChanged: (v) {
                          model.notifyListeners();
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          suffixIcon: model.searchController.value.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    model.searchController.text = '';
                                    model.notifyListeners();
                                  },
                                  icon: Icon(Icons.close),
                                  color: Colors.red,
                                ),
                          hintText: 'Search Items',
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedErrorBorder: circularBorder.copyWith(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        style: GoogleFonts.openSans(
                          color: migBlackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: 60,
                      child: TabBar(
                        onTap: (value) {
                          model.activeMenuItemsViewIsVeg = value == 0;
                          model.notifyListeners();
                        },
                        labelColor: Colors.black,
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 2,
                                          color: Color(
                                              true ? 0xff40cf6b : 0xffde2740))),
                                  padding: EdgeInsets.all(4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(
                                            true ? 0xff40cf6b : 0xffde2740)),
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Vegetarian'),
                                )
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 2,
                                          color: Color(false
                                              ? 0xff40cf6b
                                              : 0xffde2740))),
                                  padding: EdgeInsets.all(4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(
                                            false ? 0xff40cf6b : 0xffde2740)),
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Non Vegetarian'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (model.searchController.value.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 7.5),
                        child: model.getSearchResults().length != 0
                            ? Column(
                                children: List.generate(
                                    model.getSearchResults().length, (index) {
                                MenuModel selectedMenu =
                                    model.getSearchResults()[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...List.generate(selectedMenu.items.length,
                                        (itemIndex) {
                                      MenuItemModel selectedItem =
                                          selectedMenu.items[itemIndex];
                                      return getMenuItemTile(
                                          model, selectedItem);
                                    })
                                  ],
                                );
                              }))
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Center(
                                    child: Text('No Menu Items Found Named ' +
                                        model.searchController.value.text)),
                              ),
                      ),
                    if (model.searchController.value.text.isEmpty)
                      Column(
                        children: List.generate(model.menuData.length, (index) {
                          MenuModel selectedMenu = model.menuData[index];
                          return ExpansionTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedMenu.itemCategory!,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  if (selectedMenu.addedModelItems().length > 0)
                                    Text(
                                      '₹' + selectedMenu.itemsTotal.toString(),
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                ],
                              ),
                              children: selectedMenu.items
                                          .where((element) {
                                            return model
                                                    .activeMenuItemsViewIsVeg ==
                                                element.veg!;
                                          })
                                          .toList()
                                          .length ==
                                      0
                                  ? [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Text('No items added to this Menu'),
                                      )
                                    ]
                                  : selectedMenu.items
                                      .where((element) {
                                        return model.activeMenuItemsViewIsVeg ==
                                            element.veg!;
                                      })
                                      .where((element) {
                                        return element.itemName!
                                            .toLowerCase()
                                            .contains(model
                                                .searchController.value.text
                                                .toLowerCase());
                                      })
                                      .toList()
                                      .map((selectedItem) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Color(selectedItem
                                                                            .veg ??
                                                                        true
                                                                    ? 0xff40cf6b
                                                                    : 0xffde2740))),
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: Color(selectedItem
                                                                          .veg ??
                                                                      true
                                                                  ? 0xff40cf6b
                                                                  : 0xffde2740)),
                                                          height: 16,
                                                          width: 16,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          selectedItem.itemName!
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  color:
                                                                      migBlackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0),
                                                      child: Text(
                                                        '₹' +
                                                            selectedItem
                                                                .itemPrice!,
                                                        style: GoogleFonts
                                                            .openSans(
                                                                color:
                                                                    migBlackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        'X',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                color:
                                                                    migBlackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        (selectedItem
                                                                    .quantity ??
                                                                0)
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .openSans(
                                                                color:
                                                                    migBlackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ])
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      selectedItem.quantity =
                                                          selectedItem
                                                                  .quantity! +
                                                              1;
                                                      model.notifyListeners();
                                                    },
                                                    child: Text('+'),
                                                    style: getButtonStyle(
                                                            ButtonType.normal,
                                                            5.0)
                                                        .copyWith(backgroundColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    (state) {
                                                      if (state.contains(
                                                          MaterialState
                                                              .disabled)) {
                                                        return migLightGreyColor;
                                                      }
                                                      return migOrderStatusDeliveredColor;
                                                    })),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (selectedItem
                                                                .quantity! >
                                                            0) {
                                                          selectedItem
                                                                  .quantity =
                                                              selectedItem
                                                                      .quantity! -
                                                                  1;
                                                          if (selectedItem
                                                                  .quantity ==
                                                              0) {}
                                                          model
                                                              .notifyListeners();
                                                        }
                                                      },
                                                      child: Text('-'),
                                                      style: getButtonStyle(
                                                              ButtonType.normal,
                                                              5.0)
                                                          .copyWith(backgroundColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      (state) {
                                                        if (state.contains(
                                                            MaterialState
                                                                .disabled)) {
                                                          return migLightGreyColor;
                                                        }
                                                        return migOrderStatusCancelledColor;
                                                      })),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      })
                                      .toList());
                        }),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.all(0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
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
                                'Sub Total',
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
                                '₹ ${model.getOrderTotal()}',
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w300, fontSize: 22),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 5, 10),
                          child: TextFormField(
                            autovalidateMode: model.orderFormData.submitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            obscureText: false,
                            controller: model.orderFormData.deliveryCharges,
                            validator:
                                model.orderFormData.deliveryChargesValidator,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Delivery Charges',
                              labelStyle: GoogleFonts.openSans(
                                color: migBlackColor,
                                fontWeight: FontWeight.w300,
                              ),
                              hintText: 'Delivery Charges',
                              hintStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: enabledBorder,
                              disabledBorder: disabledBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedErrorBorder,
                              focusedBorder: focusedBorder,
                            ),
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                  locale: 'en_in',
                                  symbol: '₹',
                                  decimalDigits: 0)
                            ],
                            onChanged: (_) {
                              model.notifyListeners();
                            },
                            style: GoogleFonts.openSans(
                              color: migBlackColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: TextFormField(
                            autovalidateMode: model.orderFormData.submitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            obscureText: false,
                            controller: model.orderFormData.GST,
                            validator: model.orderFormData.GSTValidator,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'GST (1-100)%',
                              labelStyle: GoogleFonts.openSans(
                                color: migBlackColor,
                                fontWeight: FontWeight.w300,
                              ),
                              hintText: 'GST (1-100)%',
                              hintStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: enabledBorder,
                              disabledBorder: disabledBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedErrorBorder,
                              focusedBorder: focusedBorder,
                            ),
                            onChanged: (_) {
                              model.notifyListeners();
                            },
                            style: GoogleFonts.openSans(
                              color: migBlackColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 10),
                          child: TextFormField(
                            autovalidateMode: model.orderFormData.submitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            obscureText: false,
                            controller: model.orderFormData.serviceCharges,
                            validator:
                                model.orderFormData.serviceChargeValidator,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Service Text (1-100)%',
                              labelStyle: GoogleFonts.openSans(
                                color: migBlackColor,
                                fontWeight: FontWeight.w300,
                              ),
                              hintText: 'Service Text (1-100)%',
                              hintStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: enabledBorder,
                              disabledBorder: disabledBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedErrorBorder,
                              focusedBorder: focusedBorder,
                            ),
                            onChanged: (_) {
                              model.notifyListeners();
                            },
                            style: GoogleFonts.openSans(
                              color: migBlackColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: TextFormField(
                            autovalidateMode: model.orderFormData.submitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            obscureText: false,
                            controller: model.orderFormData.discount,
                            validator: model.orderFormData.discountValidator,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Discount (1-100)%',
                              labelStyle: GoogleFonts.openSans(
                                color: migBlackColor,
                                fontWeight: FontWeight.w300,
                              ),
                              hintText: 'Discount (1-100)%',
                              hintStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: enabledBorder,
                              disabledBorder: disabledBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedErrorBorder,
                              focusedBorder: focusedBorder,
                            ),
                            onChanged: (_) {
                              model.notifyListeners();
                            },
                            style: GoogleFonts.openSans(
                              color: migBlackColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: TextFormField(
                          autovalidateMode: model.orderFormData.submitted
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          obscureText: false,
                          controller: model.orderFormData.advancePayment,
                          validator:
                              model.orderFormData.advancePaymentValidator,
                          onChanged: (_) {
                            model.notifyListeners();
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Advance Payment',
                            labelStyle: GoogleFonts.openSans(
                              color: migBlackColor,
                              fontWeight: FontWeight.w300,
                            ),
                            hintText: 'Advance Payment',
                            hintStyle: GoogleFonts.openSans(
                              fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: enabledBorder,
                            disabledBorder: disabledBorder,
                            errorBorder: errorBorder,
                            focusedErrorBorder: focusedErrorBorder,
                            focusedBorder: focusedBorder,
                          ),
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                                locale: 'en_in', symbol: '₹', decimalDigits: 0)
                          ],
                          style: GoogleFonts.openSans(
                            color: migBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
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
                                'Sub Total',
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
                                '₹ ${model.countTotal()}',
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w300, fontSize: 22),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: model.orderFormData.validateForm() &&
                              model.getOrderTotal() == 0
                          ? null
                          : () {
                              model.placeOrder();
                            },
                      child: model.busy('addOrder')
                          ? CircularProgressIndicator(
                              strokeWidth: 1,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(migWhiteColor),
                            )
                          : Text('Place Order'),
                      style: getButtonStyle(ButtonType.normal, 5.0).copyWith(
                          minimumSize: MaterialStateProperty.resolveWith(
                              (states) => Size(double.maxFinite, 40))),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
