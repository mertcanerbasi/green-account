import 'package:flutter/material.dart';
import 'package:greenaccount/utils/colors.dart';

import '../../services/sharedPref.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            const Text("Giderleri temizle"),
            const Spacer(),
            InkWell(
              onTap: _clearExpenseList,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: primaryRed),
                ),
                child: const Center(child: Text("Temizle")),
              ),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            const Text("Gelirleri temizle"),
            const Spacer(),
            InkWell(
              onTap: _clearIncomesList,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: primaryRed),
                ),
                child: const Center(child: Text("Temizle")),
              ),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            const Text("Geçmişi temizle"),
            const Spacer(),
            InkWell(
              onTap: _clearNotificationsList,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: primaryRed),
                ),
                child: const Center(child: Text("Temizle")),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
