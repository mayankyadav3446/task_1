// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userlist_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserListResponseImpl _$$UserListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserListResponseImpl(
      page: json['page'] as int?,
      perPage: json['per_page'] as int?,
      total: json['total'] as int?,
      totalPages: json['total_pages'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserListResponseImplToJson(
        _$UserListResponseImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_pages': instance.totalPages,
      'data': instance.data,
    };
