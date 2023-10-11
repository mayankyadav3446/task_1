import 'package:freezed_annotation/freezed_annotation.dart';

part 'userdata.freezed.dart';

part 'userdata.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData(
      {int? id,
      String? email,
      @JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "last_name") String? lastName,
      String? avatar}) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
