class postsModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  postsModel({this.postId, this.id, this.name, this.email, this.body});

  postsModel.fromJson(Map<dynamic, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }
  postsModel.fromMap(Map<dynamic, dynamic> map) {
    postId = map['postId'];
    id = map['id'];
    name = map['name'];
    email = map['email'];
    body = map['body'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}
