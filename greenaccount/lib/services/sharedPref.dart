// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:greenaccount/models/app_preferences_model.dart';
import 'package:path_provider/path_provider.dart';

import '../models/income_expense_model.dart';

class DataService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileExpenses async {
    final path = await _localPath;
    return File('$path/expenseList.json');
  }

  Future<File> get _localFileIncomes async {
    final path = await _localPath;
    return File('$path/incomesList.json');
  }

  Future<File> get _localFileNotifications async {
    final path = await _localPath;
    return File('$path/notificationsList.json');
  }

  Future<File> get _localFileAppPreferences async {
    final path = await _localPath;
    return File('$path/appPreferences.json');
  }

  Future<List<IncomeExpenseModel>?> readExpenseList() async {
    try {
      final file = await _localFileExpenses;

      // Read the file
      final contents = await file.readAsString();
      List data = jsonDecode(contents);
      List<IncomeExpenseModel> list = [];
      for (var element in data) {
        list.add(IncomeExpenseModel.fromJson(element));
      }
      return list;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<List<IncomeExpenseModel>?> readIncomeList() async {
    try {
      final file = await _localFileIncomes;

      // Read the file
      final contents = await file.readAsString();
      List data = jsonDecode(contents);
      List<IncomeExpenseModel> list = [];
      for (var element in data) {
        list.add(IncomeExpenseModel.fromJson(element));
      }
      return list;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<List<IncomeExpenseModel>?> readNotificationsList() async {
    try {
      final file = await _localFileNotifications;

      // Read the file
      final contents = await file.readAsString();
      List data = jsonDecode(contents);
      List<IncomeExpenseModel> list = [];
      for (var element in data) {
        list.add(IncomeExpenseModel.fromJson(element));
      }
      return list;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<AppPreferencesModel?> readAppPreferences() async {
    try {
      final file = await _localFileAppPreferences;

      // Read the file
      final contents = await file.readAsString();

      AppPreferencesModel data =
          AppPreferencesModel.fromJson(jsonDecode(contents));

      return data;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeExpenseList(List<IncomeExpenseModel>? expenseList) async {
    final file = await _localFileExpenses;

    // Write the file
    return file.writeAsString(jsonEncode(expenseList));
  }

  Future<File> writeIncomeList(List<IncomeExpenseModel>? incomeList) async {
    final file = await _localFileIncomes;

    // Write the file
    return file.writeAsString(jsonEncode(incomeList));
  }

  Future<File> writeNotificationsList(
      List<IncomeExpenseModel>? notificationsList) async {
    final file = await _localFileNotifications;

    // Write the file
    return file.writeAsString(jsonEncode(notificationsList));
  }

  Future<File> writeAppPreferences(AppPreferencesModel? appPreferences) async {
    final file = await _localFileAppPreferences;

    // Write the file
    return file.writeAsString(jsonEncode(appPreferences));
  }

  Future<void> clearExpenseList() async {
    final file = await _localFileExpenses;

    // Write the file
    file.writeAsString('');
  }

  Future<void> clearIncomesList() async {
    final file = await _localFileIncomes;

    // Write the file
    file.writeAsString('');
  }

  Future<void> clearNotificationsList() async {
    final file = await _localFileNotifications;

    // Write the file
    file.writeAsString('');
  }

  Future<void> clearAppPreferences() async {
    final file = await _localFileAppPreferences;
    // Write the file
    file.writeAsString('');
  }
}
