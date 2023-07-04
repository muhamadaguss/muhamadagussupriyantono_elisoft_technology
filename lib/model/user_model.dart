class UserModel {
  String? name;
  String? email;
  String? phoneNumber;
  Created? created;
  String? uuid;

  UserModel({this.name, this.email, this.phoneNumber, this.created, this.uuid});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    created =
        json['created'] != null ? Created.fromJson(json['created']) : null;
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    if (created != null) {
      data['created'] = created!.toJson();
    }
    data['uuid'] = uuid;
    return data;
  }
}

class Created {
  String? date;
  int? timezoneType;
  String? timezone;

  Created({this.date, this.timezoneType, this.timezone});

  Created.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['timezone_type'] = timezoneType;
    data['timezone'] = timezone;
    return data;
  }
}
