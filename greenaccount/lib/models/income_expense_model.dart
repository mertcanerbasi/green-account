import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'income_expense_model.g.dart';

@JsonSerializable()
class IncomeExpenseModel {
  final String kalemAdi;
  bool isGelir = false;
  bool? isOdendi = false;
  final double miktar;
  final String kategori;
  final String sonOdemeTarihi;

  IncomeExpenseModel({
    required this.kalemAdi,
    required this.isGelir,
    required this.miktar,
    required this.kategori,
    required this.isOdendi,
    required this.sonOdemeTarihi,
  });

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json) => _$IncomeExpenseModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeExpenseModelToJson(this);
}
