import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/models/addOrderModel.dart';
import 'package:mig_mayo/models/menuItemModel.dart';
import 'package:mig_mayo/models/order_model.dart';
import 'package:mig_mayo/services/http_service.dart';
import 'package:mig_mayo/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddOrderViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  DateTime selectedDate = DateTime.now();
  SnackbarService _snackbarService = locator<SnackbarService>();
  HttpService _httpService = locator<HttpService>();
  SignUpFormData orderFormData = SignUpFormData();
  List<dynamic> vendorData = [];
  List<MenuItemModel> menuItemData = [];
  List<MenuModel> menuData = [];
  int step = 1;
  late int orderID;

  init() async {
    setBusyForObject('loading', true);
    notifyListeners();
    await getOrderId();
    await getVendorData();
    await getAndProcessMenuData();
    setBusyForObject('loading', false);
    notifyListeners();
  }

  getAndProcessMenuData() async {
    await getMenuItems();
    await getMenus();
    menuItemData.forEach((element) {
      menuData
          .firstWhere((menu) {
            return menu.id == int.parse(element.itemCategoryId!);
          })
          .items
          .add(element);
    });
    print(menuData);
  }

  getMenuItems() async {
    try {
      menuItemData = (jsonDecode((await _httpService.getMenuItemData())?.data!)
              as List<dynamic>)
          .map((element) {
        return MenuItemModel.fromJson(element);
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getMenus() async {
    try {
      menuData = (jsonDecode((await _httpService.getMenuData())?.data!)
              as List<dynamic>)
          .map((element) {
        return MenuModel.fromJson(element);
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getOrderId() async {
    try {
      orderID = int.parse((await _httpService.getNewOrderId())?.data!);
      orderFormData.orderId.text = orderID.toString();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  removeSigns(TextEditingController textController) {
    return textController.value.text.replaceAll("₹ ", '').replaceAll(",", '') ==
            ''
        ? '0'
        : double.parse(
            textController.value.text.replaceAll("₹ ", '').replaceAll(",", ''));
  }

  prepareOrderPayload() {
    AddOrderModel payload = AddOrderModel(
        orderStatusRemarks: '',
        remarks: '',
        status: "Active",
        vendor: orderFormData.vendor.value.text,
        contactNumber: orderFormData.contactNumber.value.text,
        customerName: orderFormData.customerName.value.text,
        deliveryDateTime: orderFormData.deliveryDateTime.value.text,
        isRead: false,
        orderId: int.parse(orderFormData.orderId.value.text),
        orderType: orderFormData.paymentType,
        pnr: orderFormData.pnr.value.text,
        trainNumName: orderFormData.trainNumName.value.text,
        itemDetails: ItemDetails(
          items: getSelectedItems(),
          advancePayment: removeSigns(orderFormData.advancePayment),
          tax: removeSigns(orderFormData.serviceCharges),
          gst: removeSigns(orderFormData.GST),
          discount: removeSigns(orderFormData.discount),
          deliveryCharges: removeSigns(orderFormData.deliveryCharges),
          totalCost: countTotal(),
          collectableAmount: getOrderTotal(),
        ),
        coachSeat: orderFormData.coachSeat.value.text);
    return payload;
  }

  getOrderTotal() {
    return menuData
        .map((e) => e.itemsTotal)
        .reduce((value, element) => value + element);
  }

  getSelectedItems() {
    List<Items> items = [];
    menuData.forEach((e) {
      e.items = e.items.where((element) => element.quantity! > 0).toList();
      items = [
        ...e.items.map((e) => Items(itemName: e.itemName, qty: e.quantity)),
        ...items
      ];
    });
    return items;
  }

  getVendorData() async {
    try {
      vendorData = await _httpService.getVendorData();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  placeOrder() {
    bool isValid = orderFormData.validateForm();
    if (isValid) {
      if (!busy('addOrder')) {
        setBusyForObject('addOrder', true);
        _httpService.addOrderData(prepareOrderPayload()).then((value) {
          setBusyForObject('addOrder', false);
        }).catchError((e) {
          setBusyForObject('addOrder', false);
        });
      }
    }
  }

  countTotal() {
    double total = getOrderTotal();
    double deliveryCharges = removeSigns(orderFormData.deliveryCharges);
    double serviceCharges = removeSigns(orderFormData.serviceCharges) / 100;
    double GST = removeSigns(orderFormData.GST) / 100;
    double discount = removeSigns(orderFormData.discount) / 100;
    double advancePayment = removeSigns(orderFormData.advancePayment);
    return total +
        deliveryCharges +
        (total * GST) +
        (total * serviceCharges) +
        (total * discount) -
        advancePayment;
  }
}

class SignUpFormData {
  bool submitted = false;
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  TextEditingController orderId = TextEditingController(text: '');
  TextEditingController vendor = TextEditingController(text: '');
  TextEditingController trainNumName = TextEditingController(text: '');
  TextEditingController coachSeat = TextEditingController(text: '');
  TextEditingController customerName = TextEditingController(text: '');
  TextEditingController contactNumber = TextEditingController(text: '');
  TextEditingController deliveryCharges = TextEditingController(text: '0');
  TextEditingController serviceCharges = TextEditingController(text: '0');
  TextEditingController discount = TextEditingController(text: '0');
  TextEditingController amountToCollect = TextEditingController(text: '0');
  TextEditingController advancePayment = TextEditingController(text: '0');
  TextEditingController GST = TextEditingController(text: '12');
  TextEditingController deliveryDateTime = TextEditingController(text: '');
  TextEditingController pnr = TextEditingController(text: '');
  String paymentType = 'COD';
  bool orderTypeIsVeg = false;
  TextEditingController isRead = TextEditingController(text: '');
  MultiValidator orderIdValidator = MultiValidator([
    RequiredValidator(errorText: 'Order ID is required'),
  ]);
  MultiValidator deliveryChargesValidator = MultiValidator([
    RequiredValidator(errorText: 'Delivery Charges is required'),
  ]);
  MultiValidator GSTValidator = MultiValidator([
    RequiredValidator(errorText: 'GST is required'),
    RangeValidator(min: 0, max: 100, errorText: 'Enter Proper Percentage Value')
  ]);
  MultiValidator serviceChargeValidator = MultiValidator([
    RequiredValidator(errorText: 'Service Charges is required'),
    RangeValidator(min: 0, max: 100, errorText: 'Enter Proper Percentage Value')
  ]);
  MultiValidator discountValidator = MultiValidator([
    RequiredValidator(errorText: 'Delivery Charges is required'),
    RangeValidator(min: 0, max: 100, errorText: 'Enter Proper Percentage Value')
  ]);

  MultiValidator vendorValidator = MultiValidator([
    RequiredNullValidator(errorText: 'Vendor is required'),
  ]);
  MultiValidator advancePaymentValidator = MultiValidator([
    RequiredNullValidator(errorText: 'Advance Payment is required'),
  ]);

  MultiValidator amountToCollectValidator = MultiValidator([
    RequiredNullValidator(errorText: 'Amount To Collect is required'),
  ]);
  MultiValidator customerNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Customer Name is required'),
  ]);
  MultiValidator contactNumberValidator = MultiValidator([
    RequiredValidator(errorText: 'Contact Number is required'),
    PhoneValidator(errorText: 'Please Enter Valid Phone Number')
  ]);
  MultiValidator deliveryDateTimeValidator = MultiValidator([
    RequiredValidator(errorText: 'Delivery Date Time is required'),
  ]);
  MultiValidator trainNumNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Train Number and Train Name is required'),
  ]);
  MultiValidator coachSeatValidator = MultiValidator([
    RequiredValidator(errorText: 'Coach Seat is required'),
  ]);
  MultiValidator pnrValidator = MultiValidator([
    RequiredValidator(errorText: 'PNR Number is required'),
  ]);
  MultiValidator orderTypeValidator = MultiValidator([
    RequiredValidator(errorText: 'Order Type is required'),
  ]);

  bool validateForm() {
    bool? isValid = formStateKey.currentState?.validate();
    submitted = true;
    return isValid ?? false;
  }
}

// class SignUpFormData {
//   bool submitted = false;
//   GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
//   TextEditingController username = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController password = TextEditingController();
//   MultiValidator usernameValidator = MultiValidator([
//     RequiredValidator(errorText: 'Name is required'),
//   ]);
//   MultiValidator emailValidator = MultiValidator([
//     RequiredValidator(errorText: 'Email is required'),
//     EmailValidator(errorText: 'Proper Email id is required')
//   ]);
//   MultiValidator phoneNumberValidator = MultiValidator([
//     RequiredValidator(errorText: 'Mobile Number is required'),
//     PhoneValidator()
//   ]);
//   MultiValidator passwordValidator =
//   MultiValidator([RequiredValidator(errorText: 'Password is required')]);
//   bool isApplicant = true;
//   bool isRecruiter = false;
//
//   Map<String, dynamic> toJson() {
//     return {
//       "username": username.value,
//       "email": email.value,
//       "phone_number": phoneNumber.value,
//       "is_applicant": true,
//       "is_recruiter": false,
//       "password": password.value
//     };
//   }
//
//   bool validateForm() {
//     bool? isValid = formStateKey.currentState?.validate();
//     submitted = true;
//     return isValid ?? false;
//   }
// }
