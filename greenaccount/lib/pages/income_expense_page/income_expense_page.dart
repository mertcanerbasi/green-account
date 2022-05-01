import 'package:flutter/material.dart';
import 'package:greenaccount/models/income_expense_model.dart';
import 'package:greenaccount/utils/colors.dart';
import 'package:greenaccount/utils/expense_categories.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/language_model.dart';
import '../../models/theme_model.dart';
import '../../services/sharedPref.dart';
import '../../utils/adaptivescreensize.dart';

class IncomeExpensePage extends StatefulWidget {
  const IncomeExpensePage({Key? key}) : super(key: key);

  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  bool isChecked = false;
  List<IncomeExpenseModel>? _expensesList = [];
  List<IncomeExpenseModel>? _selectedExpenseList = [];
  final oCcy = NumberFormat("#,##0.00", "en_EN");
  double _debtAmount = 0;
  double _paidAmount = 0;
  double _remainingAmount = 0;
  String _selectedCategory = "Hepsi";
  bool _isLoading = true;
  final DataService _dataService = DataService();
  List<IncomeExpenseModel>? notificationsList;

  Future<void> _writeToExpenseList() async {
    await _dataService.writeExpenseList(_expensesList);
  }

  Future<void> _readExpenseList() async {
    List<IncomeExpenseModel>? list = await _dataService.readExpenseList();
    setState(() {
      _expensesList = list;
      if (_expensesList?.isNotEmpty == true) {
        for (var element in _expensesList!) {
          if (!element.isGelir) {
            _debtAmount += element.miktar;
            _paidAmount += element.isOdendi == true ? element.miktar : 0;
          }
        }
      }

      _remainingAmount = _debtAmount - _paidAmount;
      _selectedExpenseList = _expensesList;
      _isLoading = false;
    });
  }

  _writeToNotificationsList() async {
    await _dataService.writeNotificationsList(notificationsList);
  }

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
    _readExpenseList();
  }

  _updateDebtPaid() {
    setState(() {
      _remainingAmount = _debtAmount - _paidAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Consumer2<ThemeModel, LanguageModel>(builder: (context,
            ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: const AdaptiveScreenSize()
                      .getadaptiveScreenSizeWidth(context, 5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: const AdaptiveScreenSize()
                            .getadaptiveScreenSizeHeight(context, 20)),
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeWidth(context, 20)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 100),
                                    child: Center(
                                      child: Text(
                                        languageNotifier.lang == "en"
                                            ? "Debt"
                                            : "Borç",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: primaryOrange,
                                  ),
                                  SizedBox(
                                    width: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 100),
                                    child: Center(
                                      child: Text(
                                        languageNotifier.lang == "en"
                                            ? "Paid"
                                            : "Ödenen",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: primaryOrange,
                                  ),
                                  SizedBox(
                                    width: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 100),
                                    child: Center(
                                      child: Text(
                                        languageNotifier.lang == "en"
                                            ? "Remained"
                                            : "Kalan",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 100),
                                    child: Center(
                                      child: Text(
                                        "${oCcy.format(_debtAmount)} ₺",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: primaryOrange,
                                  ),
                                  SizedBox(
                                    width: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 100),
                                    child: Center(
                                      child: Text(
                                        "${oCcy.format(_paidAmount)} ₺",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: primaryOrange,
                                  ),
                                  SizedBox(
                                    width: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 100),
                                    child: Center(
                                      child: Text(
                                        "${oCcy.format(_remainingAmount)} ₺",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: const AdaptiveScreenSize()
                            .getadaptiveScreenSizeHeight(context, 20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: const AdaptiveScreenSize()
                              .getadaptiveScreenSizeHeight(context, 10),
                        ),
                        SizedBox(
                          height: const AdaptiveScreenSize()
                              .getadaptiveScreenSizeHeight(context, 30),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: expenseCategoriesTexts.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: const AdaptiveScreenSize()
                                      .getadaptiveScreenSizeWidth(context, 5)),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory ==
                                            expenseCategoriesTexts[index]
                                        ? _selectedCategory = "Hepsi"
                                        : _selectedCategory =
                                            expenseCategoriesTexts[index];
                                    _selectedExpenseList = _selectedCategory ==
                                            expenseCategoriesTexts[index]
                                        ? _expensesList
                                            ?.where((element) =>
                                                element.kategori ==
                                                _selectedCategory)
                                            .toList()
                                        : _expensesList;
                                  });
                                },
                                child: Container(
                                  width: const AdaptiveScreenSize()
                                      .getadaptiveScreenSizeWidth(context, 150),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            const AdaptiveScreenSize()
                                                .getadaptiveScreenSizeHeight(
                                                    context, 10))),
                                    border: Border.all(
                                        width: 1,
                                        color: expenseCategoriesColors[index]),
                                    color: _selectedCategory ==
                                            expenseCategoriesTexts[index]
                                        ? (themeNotifier.isDark
                                            ? Colors.grey[600]
                                            : Colors.orange[50])
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      expenseCategoriesIcons[index],
                                      const Spacer(
                                        flex: 3,
                                      ),
                                      Text(languageNotifier.lang == "en"
                                          ? expenseCategoriesTextsEn[index]
                                          : expenseCategoriesTexts[index]),
                                      const Spacer(
                                        flex: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        _selectedExpenseList?.isNotEmpty == true
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeHeight(
                                            context, 20)),
                                child: SizedBox(
                                    height: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeHeight(
                                            context, 460),
                                    child: ListView.builder(
                                      itemCount: _selectedExpenseList?.length,
                                      itemBuilder: (context, index) => Padding(
                                          padding: EdgeInsets.only(
                                              top: const AdaptiveScreenSize()
                                                  .getadaptiveScreenSizeHeight(
                                                      context, 10)),
                                          child: InkWell(
                                            onLongPress: () {
                                              showDialog(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Center(
                                                        child: Text(
                                                            languageNotifier
                                                                        .lang ==
                                                                    "en"
                                                                ? "Expense Item"
                                                                : 'Gider Kalemi')),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children:
                                                            languageNotifier
                                                                        .lang ==
                                                                    "en"
                                                                ? [
                                                                    Text(
                                                                        'Expense Name: ${_selectedExpenseList?[index].kalemAdi}'),
                                                                    Text(
                                                                        'Amount : ${_selectedExpenseList?[index].miktar}'),
                                                                    Text(
                                                                        'Due Date: ${_selectedExpenseList?[index].sonOdemeTarihi}'),
                                                                    Text(
                                                                        'Category: ${_selectedExpenseList?[index].kategori == "Fatura" ? "Bill" : _selectedExpenseList?[index].kategori == "Konut" ? "Housing" : _selectedExpenseList?[index].kategori == "Kredi Kartı" ? "Credit Card" : _selectedExpenseList?[index].kategori == "Birikim" ? "Savings" : "Other"}'),
                                                                  ]
                                                                : [
                                                                    Text(
                                                                        'Kalem Adı: ${_selectedExpenseList?[index].kalemAdi}'),
                                                                    Text(
                                                                        'Tutar : ${_selectedExpenseList?[index].miktar}'),
                                                                    Text(
                                                                        'Son Ödeme Tarihi: ${_selectedExpenseList?[index].sonOdemeTarihi}'),
                                                                    Text(
                                                                        'Kategori: ${_selectedExpenseList?[index].kategori}'),
                                                                  ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Center(
                                                            child: TextButton(
                                                              child: Text(
                                                                languageNotifier
                                                                            .lang ==
                                                                        "en"
                                                                    ? "Delete"
                                                                    : 'Sil',
                                                                style: const TextStyle(
                                                                    color:
                                                                        primaryRed),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  notificationsList!.add(IncomeExpenseModel(
                                                                      kalemAdi:
                                                                          "${_expensesList![index].kalemAdi} silindi",
                                                                      isGelir:
                                                                          false,
                                                                      miktar: _expensesList![
                                                                              index]
                                                                          .miktar,
                                                                      kategori:
                                                                          _expensesList![index]
                                                                              .kategori,
                                                                      isOdendi:
                                                                          false,
                                                                      sonOdemeTarihi: DateTime
                                                                              .now()
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              10)));

                                                                  _debtAmount =
                                                                      _debtAmount -
                                                                          _expensesList![index]
                                                                              .miktar;
                                                                  _expensesList![index]
                                                                              .isOdendi ==
                                                                          true
                                                                      ? _paidAmount =
                                                                          _paidAmount -
                                                                              _expensesList![index].miktar
                                                                      : _paidAmount;
                                                                  _expensesList!
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                      content: Text(languageNotifier.lang ==
                                                                              "en"
                                                                          ? "Expense Removed"
                                                                          : 'Gider Kalemi Silindi')),
                                                                );

                                                                Navigator.pop(
                                                                    context);
                                                                await _writeToExpenseList()
                                                                    .then((value) =>
                                                                        _updateDebtPaid());
                                                                await _writeToNotificationsList();
                                                              },
                                                            ),
                                                          ),
                                                          Center(
                                                            child: TextButton(
                                                              child: Text(
                                                                languageNotifier
                                                                            .lang ==
                                                                        "en"
                                                                    ? "Cancel"
                                                                    : 'İptal',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: const AdaptiveScreenSize()
                                                  .getadaptiveScreenSizeHeight(
                                                      context, 70),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        const AdaptiveScreenSize()
                                                            .getadaptiveScreenSizeHeight(
                                                                context, 10))),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.black),
                                              ),
                                              child: ListTile(
                                                leading: _selectedExpenseList?[
                                                                index]
                                                            .kategori ==
                                                        "Konut"
                                                    ? const Icon(
                                                        Icons.apartment,
                                                        color: primaryOrange,
                                                      )
                                                    : _selectedExpenseList?[
                                                                    index]
                                                                .kategori ==
                                                            "Fatura"
                                                        ? const Icon(
                                                            Icons.receipt_long,
                                                            color: primaryRed,
                                                          )
                                                        : _selectedExpenseList?[
                                                                        index]
                                                                    .kategori ==
                                                                "Kredi Kartı"
                                                            ? const Icon(
                                                                Icons
                                                                    .credit_card,
                                                                color:
                                                                    primaryBlue,
                                                              )
                                                            : _selectedExpenseList?[
                                                                            index]
                                                                        .kategori ==
                                                                    "Birikim"
                                                                ? const Icon(
                                                                    Icons
                                                                        .savings_outlined,
                                                                    color:
                                                                        primaryPink,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .currency_lira,
                                                                    color:
                                                                        primaryBrown,
                                                                  ),
                                                title: Text(
                                                    "${_selectedExpenseList?[index].kalemAdi}\n${oCcy.format(_selectedExpenseList?[index].miktar)} ₺"),
                                                subtitle: Text(languageNotifier
                                                            .lang ==
                                                        "en"
                                                    ? "Due Date: ${_selectedExpenseList?[index].sonOdemeTarihi}"
                                                    : "Son ödeme tarihi: ${_selectedExpenseList?[index].sonOdemeTarihi}"),
                                                trailing: Checkbox(
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(primaryOrange),
                                                    value:
                                                        _selectedExpenseList?[
                                                                index]
                                                            .isOdendi,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        _selectedExpenseList?[
                                                                index]
                                                            .isOdendi = value;
                                                        _selectedExpenseList?[
                                                                        index]
                                                                    .isOdendi ==
                                                                false
                                                            ? _paidAmount -=
                                                                _selectedExpenseList![
                                                                        index]
                                                                    .miktar
                                                            : _paidAmount +=
                                                                _selectedExpenseList![
                                                                        index]
                                                                    .miktar;
                                                        _expensesList?[index]
                                                            .isOdendi = value;
                                                        _writeToExpenseList();
                                                      });
                                                      _updateDebtPaid();
                                                    }),
                                              ),
                                            ),
                                          )),
                                    )),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeHeight(
                                            context, 200)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      size: const AdaptiveScreenSize()
                                          .getadaptiveScreenSizeHeight(
                                              context, 100),
                                      color: primaryYellow,
                                    ),
                                    SizedBox(
                                      height: const AdaptiveScreenSize()
                                          .getadaptiveScreenSizeHeight(
                                              context, 20),
                                    ),
                                    Center(
                                      child: Text(
                                        languageNotifier.lang == "en"
                                            ? "No Expense Entry"
                                            : "Gider kaydı bulunmuyor",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
  }
}
