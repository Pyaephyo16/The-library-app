// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_more_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowMoreResponse _$ShowMoreResponseFromJson(Map<String, dynamic> json) =>
    ShowMoreResponse(
      status: json['status'] as String?,
      copyright: json['copyright'] as String?,
      numResults: json['num_results'] as int?,
      lastModified: json['last_modified'] as String?,
      result: (json['results'] as List<dynamic>?)
          ?.map((e) => ShowMoreResultVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShowMoreResponseToJson(ShowMoreResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'last_modified': instance.lastModified,
      'results': instance.result,
    };
