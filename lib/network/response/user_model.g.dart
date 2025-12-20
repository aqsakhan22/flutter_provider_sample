// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      fname: json['firstName'] as String,
      email: json['email'] as String,
      lname: json['lastName'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.fname,
      'email': instance.email,
      'lastName': instance.lname,
      'image': instance.image,
    };
