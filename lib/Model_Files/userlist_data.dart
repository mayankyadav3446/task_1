import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_1/Model_Files/userdata.dart';

part 'userlist_data.freezed.dart';
part 'userlist_data.g.dart';

@freezed
class UserListResponse with _$UserListResponse {
  const factory UserListResponse(
      {int? page,
      @JsonKey(name: "per_page") int? perPage,
      int? total,
      @JsonKey(name: "total_pages") int? totalPages,
      required List<UserData>? data}) = _UserListResponse;

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);
}
