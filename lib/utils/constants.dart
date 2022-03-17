class Constants {
  static String jwtKey = 'token';
  static String host = 'https://api.migmayo.com/api/';
  static String jwtRefreshKey = 'refreshToken';
}

class URLConstants {
  static String login = Constants.host + 'login';
  static String status = 'https://staging.migmayo.online/';
  static String vendorList = Constants.host + 'user/get_vendor_list';
  static String refreshToken = Constants.host + 'refresh';
  static String allOrders = Constants.host + 'orders/fetch/all_orders';
  static String activeOrders = Constants.host + 'orders/fetch/Active';
  static String cancelledOrders = Constants.host + 'orders/fetch/Cancelled';
  static String deliveredOrders = Constants.host + 'orders/fetch/Delivered';
  static String unDeliveredOrders = Constants.host + 'orders/fetch/Pending';
  static String pendingOrders = Constants.host + 'orders/fetch/Pending';
  static String setOrdersStatus = Constants.host + 'orders/set_status';
  static String manualOrder = Constants.host + 'orders/manual_order';
  static String fetchMenu = Constants.host + 'menu/fetch_categories';
  static String fetchItems = Constants.host + 'menu/fetch_items';
  static String fetchDailyBusiness = Constants.host + 'reports/daily_business';
  static String getDeliveryExecutivesDataOrder = Constants.host + 'delivery/fetch_delivery_executives';
  static String setOrderReadStatus = Constants.host + 'orders/set_read_status';
  static String setOrderReadStatusRemark = Constants.host + 'orders/set_order_remark';
  static String generateOrderId = Constants.host + 'orders/id_generation';
}


