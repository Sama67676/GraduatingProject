

class UserModel {
  String? displayName;
  String? uid;
  String? department;
  String? status;
  String? year;
  String? email;
  String? position;
  String? password;
  String? imgUrl;
  UserModel();

  UserModel.fromMap(Map<String, dynamic> data) {
    displayName = data['Name'];
    department = data['department'];
    status = data['status'];
    year = data['year'];
    email = data['email'];
    uid = data['uid'];
    position = data['position'];
    password = data['password'];
    imgUrl = data['imgUrl'];
  }

}
