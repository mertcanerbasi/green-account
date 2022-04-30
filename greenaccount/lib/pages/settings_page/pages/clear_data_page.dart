import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/language_model.dart';
import '../../../models/theme_model.dart';
import '../../../services/sharedPref.dart';
import '../../../utils/colors.dart';

class ClearDataPage extends StatefulWidget {
  const ClearDataPage({Key? key}) : super(key: key);

  @override
  State<ClearDataPage> createState() => _ClearDataPageState();
}

class _ClearDataPageState extends State<ClearDataPage> {
  final DataService _dataService = DataService();
  void _clearExpenseList() async {
    await _dataService.clearExpenseList();
  }

  void _clearIncomesList() async {
    await _dataService.clearIncomesList();
  }

  void _clearNotificationsList() async {
    await _dataService.clearNotificationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: languageNotifier.lang == "en"
              ? const Text("Clear Data")
              : const Text("Verileri Temizle"),
          centerTitle: true,
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
        ),
        body: SingleChildScrollView(
          child: ListBody(
            children: [
              InkWell(
                onTap: _clearExpenseList,
                child: ListTile(
                  title: languageNotifier.lang == "en"
                      ? const Text("Clear Expenses")
                      : const Text("Giderleri Temizle"),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                ),
              ),
              InkWell(
                onTap: _clearIncomesList,
                child: ListTile(
                  title: languageNotifier.lang == "en"
                      ? const Text("Clear Incomes")
                      : const Text("Gelirleri Temizle"),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                ),
              ),
              InkWell(
                onTap: _clearNotificationsList,
                child: ListTile(
                  title: languageNotifier.lang == "en"
                      ? const Text("Clear History")
                      : const Text("Geçmişi Temizle"),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
