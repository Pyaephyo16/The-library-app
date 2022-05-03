// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverViewResponse _$OverViewResponseFromJson(Map<String, dynamic> json) =>
    OverViewResponse(
      status: json['status'] as String?,
      copyRight: json['copyright'] as String?,
      numResults: (json['num_results'] as num?)?.toDouble(),
      results: json['results'] == null
          ? null
          : ResultVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OverViewResponseToJson(OverViewResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyRight,
      'num_results': instance.numResults,
      'results': instance.results,
    };
