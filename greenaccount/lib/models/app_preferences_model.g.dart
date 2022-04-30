// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPreferencesModel _$AppPreferencesModelFromJson(Map<String, dynamic> json) =>
    AppPreferencesModel(
      theme: json['theme'] as bool?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$AppPreferencesModelToJson(
        AppPreferencesModel instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'language': instance.language,
    };
