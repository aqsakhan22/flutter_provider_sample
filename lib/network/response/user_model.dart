import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'firstName')
  final String fname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'lastName')
  final String lname;
  @JsonKey(name: 'image')
  final String image;
  UserModel({required this.id, required this.fname, required this.email, required this.lname, required this.image});
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);


}
