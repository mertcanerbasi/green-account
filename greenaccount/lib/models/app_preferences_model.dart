import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'app_preferences_model.g.dart';

@JsonSerializable()
class AppPreferencesModel {
  bool? theme;
  String? language;

  AppPreferencesModel({
    this.theme,
    this.language,
  });

  factory AppPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$AppPreferencesModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppPreferencesModelToJson(this);
}
