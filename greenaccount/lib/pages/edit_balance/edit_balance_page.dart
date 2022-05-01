import 'package:flutter/material.dart';
import 'package:greenaccount/models/income_expense_model.dart';
import 'package:greenaccount/services/sharedPref.dart';
import 'package:provider/provider.dart';

import '../../models/language_model.dart';
import '../../models/theme_model.dart';
import '../../utils/adaptivescreensize.dart';
import '../../utils/adaptivetextsize.dart';
import '../../utils/colors.dart';
import '../../utils/expense_categories.dart';

class EditBalancePage extends StatefulWidget {
  const EditBalancePage({Key? key}) : super(key: key);

  @override
  State<EditBalancePage> createState() => _EditBalancePageState();
}

class _EditBalancePageState extends State<EditBalancePage> {
  String _selectedCategory = "Diğer";
  final TextEditingController _kalemController = TextEditingController();
  final TextEditingController _tutarController = TextEditingController();
  final TextEditingController _sonOdemeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final DataService _dataService = DataService();
  List<IncomeExpenseModel>? expensesList;
  List<IncomeExpenseModel>? incomesList;
  List<IncomeExpenseModel>? notificationsList;
  String _selectedProcess = "Expense";

  _writeToExpenseList() async {
    await _dataService.writeExpenseList(expensesList);
  }

  _writeToIncomeList() async {
    await _dataService.writeIncomeList(incomesList);
  }

  _writeToNotificationsList() async {
    await _dataService.writeNotificationsList(notificationsList);
  }

  void _readExpenseList() async {
    var list = await _dataService.readExpenseList();
    setState(() {
      list?.isNotEmpty == true ? expensesList = list : expensesList = [];
    });
  }

  void _readIncomesList() async {
    var list = await _dataService.readIncomeList();
    setState(() {
      list?.isNotEmpty == true ? incomesList = list : incomesList = [];
    });
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
    _readExpenseList();
    _readIncomesList();
    _readNotificationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: const AdaptiveScreenSize()
                .getadaptiveScreenSizeWidth(context, 10)),
        child: ListView(
          children: [
            SizedBox(
              height: const AdaptiveScreenSize()
                  .getadaptiveScreenSizeHeight(context, 20),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: const AdaptiveScreenSize()
                      .getadaptiveScreenSizeHeight(context, 20),
                  left: const AdaptiveScreenSize()
                      .getadaptiveScreenSizeWidth(context, 10),
                  right: const AdaptiveScreenSize()
                      .getadaptiveScreenSizeWidth(context, 10)),
              child: SizedBox(
                height: const AdaptiveScreenSize()
                    .getadaptiveScreenSizeHeight(context, 40),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProcess = "Expense";
                        });
                      },
                      child: Container(
                        width: const AdaptiveScreenSize()
                            .getadaptiveScreenSizeWidth(context, 180),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                const AdaptiveScreenSize()
                                    .getadaptiveScreenSizeWidth(context, 10))),
                            border: Border.all(width: 1, color: primaryOrange),
                            color: _selectedProcess == "Expense"
                                ? (themeNotifier.isDark
                                    ? Colors.grey[600]
                                    : Colors.orange[50])
                                : null),
                        child: Center(
                          child: Text(
                              languageNotifier.lang == "en"
                                  ? "Expense"
                                  : "Gider",
                              style: TextStyle(
                                  fontSize: const AdaptiveTextSize()
                                      .getadaptiveTextSize(context, 20))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: const AdaptiveScreenSize()
                          .getadaptiveScreenSizeWidth(context, 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProcess = "Income";
                        });
                      },
                      child: Container(
                        width: const AdaptiveScreenSize()
                            .getadaptiveScreenSizeWidth(context, 180),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                const AdaptiveScreenSize()
                                    .getadaptiveScreenSizeHeight(context, 10))),
                            border: Border.all(width: 1, color: primaryOrange),
                            color: _selectedProcess == "Income"
                                ? (themeNotifier.isDark
                                    ? Colors.grey[600]
                                    : Colors.orange[50])
                                : null),
                        child: Center(
                          child: Text(
                              languageNotifier.lang == "en"
                                  ? "Income"
                                  : "Gelir",
                              style: TextStyle(
                                  fontSize: const AdaptiveTextSize()
                                      .getadaptiveTextSize(context, 20))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: const AdaptiveScreenSize()
                  .getadaptiveScreenSizeHeight(context, 20),
            ),
            _selectedProcess == "Expense"
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 20)),
                          child: TextFormField(
                            autocorrect: false,
                            cursorColor: primaryOrange,
                            maxLength: 20,
                            controller: _kalemController,
                            decoration: InputDecoration(
                              label: Text(languageNotifier.lang == "en"
                                  ? "Expense Name"
                                  : "Kalem Adı"),
                              icon: const Icon(
                                Icons.abc,
                                color: primaryOrange,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              labelStyle: const TextStyle(color: primaryOrange),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languageNotifier.lang == "en"
                                    ? "Expense name cannot be empty"
                                    : "Kalem adı boş bırakılamaz";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 20)),
                          child: TextFormField(
                            autocorrect: false,
                            cursorColor: primaryOrange,
                            maxLength: 10,
                            controller: _tutarController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                                label: Text(languageNotifier.lang == "en"
                                    ? "Amount"
                                    : "Tutar"),
                                icon: const Icon(
                                  Icons.currency_lira,
                                  color: primaryOrange,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                labelStyle:
                                    const TextStyle(color: primaryOrange)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languageNotifier.lang == "en"
                                    ? "Amount cannot be empty"
                                    : "Tutar boş bırakılamaz";
                              } else if (value.contains(",")) {
                                return languageNotifier.lang == "en"
                                    ? "Use dot for decimal place"
                                    : "Ondalık basamak için nokta kullanınız";
                              } else if (double.parse(value) <= 0) {
                                return languageNotifier.lang == "en"
                                    ? "Amount must be greater than zero"
                                    : "Miktar sıfırdan büyük olmalıdır";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 20)),
                          child: TextFormField(
                            autocorrect: false,
                            cursorColor: primaryOrange,
                            maxLength: 10,
                            keyboardType: TextInputType.datetime,
                            controller: _sonOdemeController,
                            decoration: InputDecoration(
                                label: Text(languageNotifier.lang == "en"
                                    ? "Due Date (dd-MM-yyyy)"
                                    : "Son Ödeme Tarihi (gg-AA-yyyy)"),
                                icon: const Icon(
                                  Icons.date_range,
                                  color: primaryOrange,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                labelStyle:
                                    const TextStyle(color: primaryOrange)),
                            validator: (value) {
                              try {
                                if (value == null || value.isEmpty) {
                                  return languageNotifier.lang == "en"
                                      ? "Due Date cannot be empty"
                                      : "Son Ödeme Tarihi boş bırakılamaz";
                                } else if (int.parse(value.substring(0, 1)) >
                                    31) {
                                  return languageNotifier.lang == "en"
                                      ? "Please enter format as dd-mm-yyyy"
                                      : "Lütfen gg-AA-yyyy şeklinde giriş yapınız";
                                } else if (int.parse(value.substring(3, 5)) >
                                    12) {
                                  return languageNotifier.lang == "en"
                                      ? "Please enter format as dd-mm-yyyy"
                                      : "Lütfen gg-AA-yyyy şeklinde giriş yapınız";
                                }
                              } catch (e) {
                                return languageNotifier.lang == "en"
                                    ? "Please enter format as dd-mm-yyyy"
                                    : "Lütfen gg-AA-yyyy şeklinde giriş yapınız";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 20)),
                          child: SizedBox(
                            height: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeHeight(context, 30),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: expenseCategoriesTexts.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 5)),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedCategory =
                                          expenseCategoriesTexts[index];
                                    });
                                  },
                                  child: Container(
                                    width: const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 150),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              const AdaptiveScreenSize()
                                                  .getadaptiveScreenSizeWidth(
                                                      context, 10))),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              expenseCategoriesColors[index]),
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
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeWidth(context, 90),
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 60)),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(
                                          child: Text(
                                              languageNotifier.lang == "en"
                                                  ? 'Expense Item'
                                                  : 'Gider Kalemi')),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children:
                                              languageNotifier.lang == "en"
                                                  ? [
                                                      Text(
                                                          'Expense Name: ${_kalemController.text}'),
                                                      Text(
                                                          'Amount : ${_tutarController.text}'),
                                                      Text(
                                                          'Due Date: ${_sonOdemeController.text}'),
                                                      Text(
                                                          'Category: ${_selectedCategory == "Fatura" ? "Bill" : _selectedCategory == "Konut" ? "Housing" : _selectedCategory == "Kredi Kartı" ? "Credit Card" : _selectedCategory == "Birikim" ? "Savings" : "Other"}'),
                                                    ]
                                                  : [
                                                      Text(
                                                          'Kalem Adı: ${_kalemController.text}'),
                                                      Text(
                                                          'Tutar : ${_tutarController.text}'),
                                                      Text(
                                                          'Son Ödeme Tarihi: ${_sonOdemeController.text}'),
                                                      Text(
                                                          'Kategori: $_selectedCategory'),
                                                    ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Center(
                                              child: TextButton(
                                                child: Text(
                                                  languageNotifier.lang == "en"
                                                      ? 'Edit'
                                                      : 'Düzenle',
                                                  style: const TextStyle(
                                                      color: primaryRed),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            Center(
                                              child: TextButton(
                                                child: Text(
                                                  languageNotifier.lang == "en"
                                                      ? 'Add'
                                                      : 'Ekle',
                                                  style: const TextStyle(
                                                      color: Colors.green),
                                                ),
                                                onPressed: () async {
                                                  expensesList!.add(
                                                      IncomeExpenseModel(
                                                          kalemAdi:
                                                              _kalemController
                                                                  .text,
                                                          isGelir: false,
                                                          miktar: double.parse(
                                                              _tutarController
                                                                  .text),
                                                          kategori:
                                                              _selectedCategory,
                                                          isOdendi: false,
                                                          sonOdemeTarihi:
                                                              _sonOdemeController
                                                                  .text));
                                                  notificationsList!.add(
                                                      IncomeExpenseModel(
                                                          kalemAdi:
                                                              _kalemController
                                                                  .text,
                                                          isGelir: false,
                                                          miktar: double.parse(
                                                              _tutarController
                                                                  .text),
                                                          kategori:
                                                              _selectedCategory,
                                                          isOdendi: false,
                                                          sonOdemeTarihi:
                                                              DateTime.now()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10)));
                                                  _kalemController.clear();
                                                  _tutarController.clear();
                                                  _sonOdemeController.clear();
                                                  await _writeToExpenseList();
                                                  await _writeToNotificationsList();

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(languageNotifier
                                                                    .lang ==
                                                                "en"
                                                            ? "Expense Item Added"
                                                            : 'Gider Kalemi Eklendi')),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 50),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(width: 1, color: primaryOrange),
                              ),
                              child: Center(
                                  child: Text(languageNotifier.lang == "en"
                                      ? "Add Expense"
                                      : "Gider Ekle")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Form(
                    key: _formKey2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 20)),
                          child: TextFormField(
                            autocorrect: false,
                            cursorColor: primaryOrange,
                            controller: _kalemController,
                            maxLength: 20,
                            decoration: InputDecoration(
                              label: Text(languageNotifier.lang == "en"
                                  ? "Income Name"
                                  : "Gelir Adı"),
                              icon: const Icon(
                                Icons.abc,
                                color: primaryOrange,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              labelStyle: const TextStyle(color: primaryOrange),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languageNotifier.lang == "en"
                                    ? "Expense name cannot be empty"
                                    : "Kalem adı boş bırakılamaz";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 20)),
                          child: TextFormField(
                            autocorrect: false,
                            cursorColor: primaryOrange,
                            controller: _tutarController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                                label: Text(languageNotifier.lang == "en"
                                    ? "Amount"
                                    : "Tutar"),
                                icon: const Icon(
                                  Icons.currency_lira,
                                  color: primaryOrange,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                labelStyle:
                                    const TextStyle(color: primaryOrange)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languageNotifier.lang == "en"
                                    ? "Amount cannot be empty"
                                    : "Tutar boş bırakılamaz";
                              } else if (value.contains(",")) {
                                return languageNotifier.lang == "en"
                                    ? "Use dot for decimal place"
                                    : "Ondalık basamak için nokta kullanınız";
                              } else if (double.parse(value) <= 0) {
                                return languageNotifier.lang == "en"
                                    ? "Amount must be greater than zero"
                                    : "Miktar sıfırdan büyük olmalıdır";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 20)),
                          child: TextFormField(
                            autocorrect: false,
                            cursorColor: primaryOrange,
                            keyboardType: TextInputType.datetime,
                            maxLength: 10,
                            controller: _sonOdemeController,
                            decoration: InputDecoration(
                                label: Text(languageNotifier.lang == "en"
                                    ? "Income Date (dd-MM-yyyy)"
                                    : "Gelir Tarihi (gg-AA-yyyy)"),
                                icon: const Icon(
                                  Icons.date_range,
                                  color: primaryOrange,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryOrange),
                                ),
                                labelStyle:
                                    const TextStyle(color: primaryOrange)),
                            validator: (value) {
                              try {
                                if (value == null || value.isEmpty) {
                                  return languageNotifier.lang == "en"
                                      ? "Due Date cannot be empty"
                                      : "Son Ödeme Tarihi boş bırakılamaz";
                                } else if (int.parse(value.substring(0, 1)) >
                                    31) {
                                  return languageNotifier.lang == "en"
                                      ? "Please enter format as dd-mm-yyyy"
                                      : "Lütfen gg-AA-yyyy şeklinde giriş yapınız";
                                } else if (int.parse(value.substring(3, 5)) >
                                    12) {
                                  return languageNotifier.lang == "en"
                                      ? "Please enter format as dd-mm-yyyy"
                                      : "Lütfen gg-AA-yyyy şeklinde giriş yapınız";
                                }
                              } catch (e) {
                                return languageNotifier.lang == "en"
                                    ? "Please enter format as dd-mm-yyyy"
                                    : "Lütfen gg-AA-yyyy şeklinde giriş yapınız";
                              }

                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeWidth(context, 90),
                              right: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeWidth(context, 90),
                              top: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 130)),
                          child: InkWell(
                            onTap: () {
                              if (_formKey2.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(
                                          child: Text(
                                              languageNotifier.lang == "en"
                                                  ? "Expense Item"
                                                  : 'Gider Kalemi')),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children:
                                              languageNotifier.lang == "en"
                                                  ? [
                                                      Text(
                                                          'Expense Name: ${_kalemController.text}'),
                                                      Text(
                                                          'Amount : ${_tutarController.text}'),
                                                      Text(
                                                          'Due Date: ${_sonOdemeController.text}'),
                                                    ]
                                                  : [
                                                      Text(
                                                          'Kalem Adı: ${_kalemController.text}'),
                                                      Text(
                                                          'Tutar : ${_tutarController.text}'),
                                                      Text(
                                                          'Son Ödeme Tarihi: ${_sonOdemeController.text}'),
                                                    ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Center(
                                              child: TextButton(
                                                child: Text(
                                                  languageNotifier.lang == "en"
                                                      ? "Edit"
                                                      : 'Düzenle',
                                                  style: const TextStyle(
                                                      color: primaryRed),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            Center(
                                              child: TextButton(
                                                child: Text(
                                                  languageNotifier.lang == "en"
                                                      ? "Add"
                                                      : 'Ekle',
                                                  style: const TextStyle(
                                                      color: Colors.green),
                                                ),
                                                onPressed: () async {
                                                  incomesList!.add(
                                                      IncomeExpenseModel(
                                                          kalemAdi:
                                                              _kalemController
                                                                  .text,
                                                          isGelir: true,
                                                          miktar: double.parse(
                                                              _tutarController
                                                                  .text),
                                                          kategori: "Gelir",
                                                          isOdendi: false,
                                                          sonOdemeTarihi:
                                                              _sonOdemeController
                                                                  .text));
                                                  notificationsList!.add(
                                                      IncomeExpenseModel(
                                                          kalemAdi:
                                                              _kalemController
                                                                  .text,
                                                          isGelir: true,
                                                          miktar: double.parse(
                                                              _tutarController
                                                                  .text),
                                                          kategori: "Gelir",
                                                          isOdendi: false,
                                                          sonOdemeTarihi:
                                                              DateTime.now()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10)));
                                                  _kalemController.clear();
                                                  _tutarController.clear();
                                                  _sonOdemeController.clear();
                                                  await _writeToIncomeList();
                                                  await _writeToNotificationsList();

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            languageNotifier
                                                                        .lang ==
                                                                    "en"
                                                                ? "Income Added"
                                                                : 'Gelir Eklendi')),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 50),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeWidth(
                                            context, 10))),
                                border:
                                    Border.all(width: 1, color: primaryOrange),
                              ),
                              child: Center(
                                  child: Text(languageNotifier.lang == "en"
                                      ? "Add Income"
                                      : "Gelir Ekle")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      );
    });
  }
}
