class RegisterModel {
  int? status;
  Data? data;
  String? message;
  String? userMsg;

  RegisterModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });
}

class Data {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  dynamic profilePic;
  dynamic countryId;
  String? gender;
  String? phoneNo;
  dynamic dob;
  bool? isActive;
  String? created;
  String? modified;
  String? accessToken;

  Data({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.profilePic,
    this.countryId,
    this.gender,
    this.phoneNo,
    this.dob,
    this.isActive,
    this.created,
    this.modified,
    this.accessToken,
  });
}
