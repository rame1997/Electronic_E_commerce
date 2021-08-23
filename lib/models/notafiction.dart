class Notifation {
  late int id;
 late  String title;
  late String subtitle;
  late String body;
  late String sentAt;
  late int userId;
  late String createdAt;
  late String updatedAt;


  Notifation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    body = json['body'];
    sentAt = json['sent_at'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['body'] = this.body;
    data['sent_at'] = this.sentAt;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}