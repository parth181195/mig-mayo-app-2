/// uuid : "698f1b75-bbd1-419a-ab93-f74431ff7bbc"
/// device_token : "cbmkU4STayTSgWW_aHxKoE:APA91bELzjTefCHxymnhTH6EMKGNq8YaMRvtljhlI6naKBco_2EOd54u7njn-TG33pnxrJA2nYumhdiH5v7_xov4zTbGQz4DjZhLLesvlV8rLWk-ZTILuPQQuzv5lkTvjfw4z-xpsP5s"
/// Type : "desktop"

class TokenSyncModel {
  TokenSyncModel({
      this.uuid, 
      this.deviceToken, 
      this.type,});

  TokenSyncModel.fromJson(dynamic json) {
    uuid = json['uuid'];
    deviceToken = json['device_token'];
    type = json['Type'];
  }
  String? uuid;
  String? deviceToken;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = uuid;
    map['device_token'] = deviceToken;
    map['Type'] = type;
    return map;
  }

}