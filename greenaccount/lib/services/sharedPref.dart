// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/income_expense_model.dart';

class DataService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/expenseList.json');
  }

  Future<List<IncomeExpenseModel>?> readExpenseList() async {
    try {
      final file = await _localFile;

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

  Future<File> writeExpenseList(List<IncomeExpenseModel>? expenseList) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(jsonEncode(expenseList));
  }

  Future<void> clearExpenseList() async {
    final file = await _localFile;

    // Write the file
    file.writeAsString('');
  }
}
