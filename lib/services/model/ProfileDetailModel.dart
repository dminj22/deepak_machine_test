import 'dart:convert';
ProfileDetailModel profileDetailModelFromJson(String str) => ProfileDetailModel.fromJson(json.decode(str));
String profileDetailModelToJson(ProfileDetailModel data) => json.encode(data.toJson());
class ProfileDetailModel {
  ProfileDetailModel({
      Data? data, 
      Support? support,}){
    _data = data;
    _support = support;
}

  ProfileDetailModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _support = json['support'] != null ? Support.fromJson(json['support']) : null;
  }
  Data? _data;
  Support? _support;

  Data? get data => _data;
  Support? get support => _support;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_support != null) {
      map['support'] = _support?.toJson();
    }
    return map;
  }

}

Support supportFromJson(String str) => Support.fromJson(json.decode(str));
String supportToJson(Support data) => json.encode(data.toJson());
class Support {
  Support({
      String? url, 
      String? text,}){
    _url = url;
    _text = text;
}

  Support.fromJson(dynamic json) {
    _url = json['url'];
    _text = json['text'];
  }
  String? _url;
  String? _text;

  String? get url => _url;
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['text'] = _text;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? email, 
      String? firstName, 
      String? lastName, 
      String? avatar,}){
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _avatar = avatar;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _avatar = json['avatar'];
  }
  num? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _avatar;

  num? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['avatar'] = _avatar;
    return map;
  }

}