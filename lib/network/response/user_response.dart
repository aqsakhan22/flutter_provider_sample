import 'package:json_annotation/json_annotation.dart';
import 'package:providerproject/network/response/user_model.dart';


part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {

  @JsonKey(name: 'users')
  final List<UserModel> users;
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'skip')
  final int skip;
  @JsonKey(name: 'limit')
  final int limit;

  UserResponse({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
