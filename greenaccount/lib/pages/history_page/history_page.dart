import 'package:flutter/material.dart';
import 'package:greenaccount/services/sharedPref.dart';
import 'package:greenaccount/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/income_expense_model.dart';
import '../../models/language_model.dart';
import '../../models/theme_model.dart';
import '../../utils/adaptivescreensize.dart';
import '../../utils/adaptivetextsize.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DataService _dataService = DataService();
  final oCcy = NumberFormat("#,##0.00", "en_EN");
  bool _isLoading = true;

  List<IncomeExpenseModel>? notificationsList;
  void _readNotificationsList() async {
    var list = await _dataService.readNotificationsList();
    setState(() {
      list?.isNotEmpty == true
          ? notificationsList = list
          : notificationsList = [];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _readNotificationsList();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : (notificationsList?.isNotEmpty == true
            ? Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: notificationsList?.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: const AdaptiveScreenSize()
                          .getadaptiveScreenSizeHeight(context, 70),
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
                            ? Text(
                                "${notificationsList?[index].sonOdemeTarihi}")
                            : Text(
                                "${notificationsList?[index].sonOdemeTarihi}"),
                        trailing: notificationsList?[index].isGelir == true
                            ? Text(
                                "${oCcy.format(notificationsList?[index].miktar)} ₺",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "-${oCcy.format(notificationsList?[index].miktar)} ₺",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    );
                  },
                ),
              )
            : Consumer2<ThemeModel, LanguageModel>(builder: (context,
                ThemeModel themeNotifier,
                LanguageModel languageNotifier,
                child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      size: const AdaptiveScreenSize()
                          .getadaptiveScreenSizeHeight(context, 100),
                      color: primaryYellow,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        languageNotifier.lang == "en"
                            ? "No History Record Found"
                            : "Geçmiş Kayıt Bulunmuyor",
                        style: TextStyle(
                            fontSize: const AdaptiveTextSize()
                                .getadaptiveTextSize(context, 20)),
                      ),
                    ),
                  ],
                );
              }));
  }
}
