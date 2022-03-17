/// response : "orders status updated successfull"
/// status : true

class SetOrderStatusResponseModel {
  SetOrderStatusResponseModel({
      this.response, 
      this.status,});

  SetOrderStatusResponseModel.fromJson(dynamic json) {
    response = json['response'];
    status = json['status'];
  }
  String? response;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response'] = response;
    map['status'] = status;
    return map;
  }

}