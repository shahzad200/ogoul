class LoginModel {
  LoginModel({
    this.action,
    this.meta,
    this.data,
  });

  String? action;
  Meta? meta;
  Data? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    meta = Meta.fromJson(json['meta']);
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['action'] = action;
    _data['meta'] = meta!.toJson();
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Meta {
  Meta({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  Meta.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    return _data;
  }
}


class Data {
  Data({
    this.id,
    this.parentId,
    this.name,
    this.address,
    this.city,
    this.state,
    this.country,
    this.phone,
    this.email,
    this.apiToken,
    this.role
  });
  int? id;
  int? parentId;
  String? name;
  String? address;
  String? city;
  String? state;
  int? country;
  String? phone;
  String? email;
  String? apiToken;
  String? role;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    apiToken = json['api_token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parent_id'] = parentId;
    _data['name'] = name;
    _data['address'] = address;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['api_token'] = apiToken;
    _data['role'] = role;
    return _data;
  }

}
