// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      user_id: json['user_id'] as int?,
      username: json['username'] as String?,
      userFName: json['userFName'] as String?,
      userLName: json['userLName'] as String?,
      userEmail: json['userEmail'] as String?,
      userPassword: json['userPassword'] as String?,
      userCity: json['userCity'] as String?,
      userStreet: json['userStreet'] as String?,
      userPhone: json['userPhone'] as String?,
      userPhoto: json['userPhoto'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'username': instance.username,
      'userFName': instance.userFName,
      'userLName': instance.userLName,
      'userEmail': instance.userEmail,
      'userPassword': instance.userPassword,
      'userCity': instance.userCity,
      'userStreet': instance.userStreet,
      'userPhone': instance.userPhone,
      'userPhoto': instance.userPhoto,
    };
