import 'package:flutter/material.dart';
import 'package:greenaccount/services/sharedPref.dart';
import 'package:greenaccount/utils/colors.dart';
import 'package:intl/intl.dart';

import '../../models/income_expense_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DataService _dataService = DataService();
  final oCcy = NumberFormat("#,##0.00", "en_EN");

  List<IncomeExpenseModel>? notificationsList;
  void _readNotificationsList() async {
    var list = await _dataService.readNotificationsList();
    setState(() {
      list?.isNotEmpty == true
          ? notificationsList = list
          : notificationsList = [];
    });
  }

  @override
  void initState() {
    super.initState();

    _readNotificationsList();
  }

  @override
  Widget build(BuildContext context) {
    return notificationsList?.isNotEmpty == true
        ? ListView.builder(
            itemCount: notificationsList?.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 70,
                child: ListTile(
                  leading: Icon(
                    Icons.currency_lira_outlined,
                    color: notificationsList?[index].isGelir == true
                        ? primaryGreen
                        : primaryRed,
                  ),
                  title: Text(
                    "${notificationsList?[index].kalemAdi}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: notificationsList?[index].isGelir == true
                      ? Text("${notificationsList?[index].sonOdemeTarihi}")
                      : Text("${notificationsList?[index].sonOdemeTarihi}"),
                  trailing: notificationsList?[index].isGelir == true
                      ? Text(
                          "${oCcy.format(notificationsList?[index].miktar)} ₺",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "-${oCcy.format(notificationsList?[index].miktar)} ₺",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              );
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                size: 100,
                color: primaryYellow,
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Geçmiş Kayıt Bulunmuyor",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
  }
}
