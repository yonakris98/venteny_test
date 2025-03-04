import 'package:json_annotation/json_annotation.dart';
import 'package:venteny_test/features/login/domain/entities/user_entities.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntities {
  const UserModel({required String token})
      : super(
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
