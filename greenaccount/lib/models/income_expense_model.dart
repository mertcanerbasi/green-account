import 'dart:convert';
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

  Map<String, double> toPieChartMap() {
    // ignore: unnecessary_this
    String data = '{ "${this.kategori}": ${this.miktar} }';
    Map<String, dynamic> mappedData = jsonDecode(data);
    Map<String, double> returnData = mappedData
        .map((key, value) => MapEntry(key, double.parse(value.toString())));
    return returnData;
  }

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeExpenseModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeExpenseModelToJson(this);
}
