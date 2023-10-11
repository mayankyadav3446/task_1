import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_response.freezed.dart';


@freezed
class MyResponse with _$MyResponse{
  const factory  MyResponse.initial() = _Initial;
  const factory  MyResponse.success(dynamic data) = _Success;
  const factory  MyResponse.loading() = _Loading;
  const factory  MyResponse.error(String error) = _Error;
}