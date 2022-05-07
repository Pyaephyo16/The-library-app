// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSearchResponse _$GoogleSearchResponseFromJson(
        Map<String, dynamic> json) =>
    GoogleSearchResponse(
      kind: json['kind'] as String?,
      totalItems: json['totalItems'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SearchResultVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoogleSearchResponseToJson(
        GoogleSearchResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
