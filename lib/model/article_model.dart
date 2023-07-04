class ArticleModel {
  String? uuid;
  String? title;
  String? content;
  String? image;
  int? views;
  Created? created;
  User? user;

  ArticleModel(
      {this.uuid,
      this.title,
      this.content,
      this.image,
      this.views,
      this.created,
      this.user});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    views = json['views'];
    created =
        json['created'] != null ? Created.fromJson(json['created']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['views'] = views;
    if (created != null) {
      data['created'] = created!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
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

class User {
  String? name;
  String? email;
  String? phoneNumber;
  Created? created;
  String? uuid;

  User({this.name, this.email, this.phoneNumber, this.created, this.uuid});

  User.fromJson(Map<String, dynamic> json) {
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
