// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeExpenseModel _$IncomeExpenseModelFromJson(Map<String, dynamic> json) =>
    IncomeExpenseModel(
      kalemAdi: json['kalemAdi'] as String,
      isGelir: json['isGelir'] as bool,
      miktar: (json['miktar'] as num).toDouble(),
      kategori: json['kategori'] as String,
      isOdendi: json['isOdendi'] as bool?,
      sonOdemeTarihi: json['sonOdemeTarihi'] as String,
    );

Map<String, dynamic> _$IncomeExpenseModelToJson(IncomeExpenseModel instance) =>
    <String, dynamic>{
      'kalemAdi': instance.kalemAdi,
      'isGelir': instance.isGelir,
      'isOdendi': instance.isOdendi,
      'miktar': instance.miktar,
      'kategori': instance.kategori,
      'sonOdemeTarihi': instance.sonOdemeTarihi,
    };
