import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


@JsonSerializable()
class UserModel {
  int? user_id;
  String? username;
  String? userFName;
  String? userLName;
  String? userEmail;
  String? userPassword;
  String? userAddress;
  String? userPhone;
  String? userPhoto;

  UserModel({
    this.user_id,
    this.username,
    this.userFName,
    this.userLName,
    this.userEmail,
    this.userPassword,
    this.userAddress,
    this.userPhone,
    this.userPhoto,
  }
    
  );
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}