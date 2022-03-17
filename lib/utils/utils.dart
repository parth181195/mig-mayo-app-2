import 'package:form_field_validator/form_field_validator.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_ui/mig_ui.dart';

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
    case OrderStatus.Pending:
      return migOrderStatusPendingColor;
    case OrderStatus.Undelivered:
      return migOrderStatusUndeliveredColor;
  }
}

getOrderEnumFromString(String orderStatus) {
  switch (orderStatus) {
    case 'all':
      return OrderStatus.All;
    case 'active':
      return OrderStatus.Active;
    case 'canceled':
      return OrderStatus.Cancelled;
    case 'delivered':
      return OrderStatus.Delivered;
    case 'unDelivered':
      return OrderStatus.Undelivered;
    case 'pending':
      return OrderStatus.Pending;
  }
}

getOrderDisplayString(String orderStatus) {
  switch (orderStatus) {
    case 'all':
      return 'All';
    case 'active':
      return 'Active';
    case 'canceled':
      return 'Canceled';
    case 'delivered':
      return 'Delivered';
    case 'unDelivered':
      return 'UnDelivered';
    case 'pending':
      return 'Pending';
  }
}

class PhoneValidator extends TextFieldValidator {
  // pass the error text to the super constructor
  PhoneValidator({String errorText = 'enter a valid phone number'})
      : super(errorText);

  // return false if you want the validator to return error
  // message when the value is empty.
  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String? value) {
    // return true if the value is valid according the your condition
    return hasMatch(
        r'^(?:(?:\+|0{0,2})91(\s*[\ -]\s*)?|[0]?)?[789]\d{9}|(\d[ -]?){10}\d$',
        value!);
  }
}

class RequiredNullValidator extends TextFieldValidator {
  // pass the error text to the super constructor
  RequiredNullValidator({String errorText = 'enter a valid phone number'})
      : super(errorText);

  // return false if you want the validator to return error
  // message when the value is empty.
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    // return true if the value is valid according the your condition
    return value != '' && value != null;
  }
}
