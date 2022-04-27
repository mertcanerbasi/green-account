import 'package:flutter/material.dart';
import 'package:greenaccount/models/income_expense_model.dart';
import 'package:greenaccount/services/sharedPref.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedProcess = "Expense";
                      });
                    },
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: primaryOrange),
                          color: _selectedProcess == "Expense"
                              ? Colors.orange[50]
                              : null),
                      child: const Center(
                        child: Text("Gider", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedProcess = "Income";
                      });
                    },
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: primaryOrange),
                          color: _selectedProcess == "Income"
                              ? Colors.orange[50]
                              : null),
                      child: const Center(
                        child: Text("Gelir", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _selectedProcess == "Expense"
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          autocorrect: false,
                          cursorColor: primaryOrange,
                          controller: _kalemController,
                          decoration: const InputDecoration(
                            label: Text("Kalem Adı"),
                            icon: Icon(
                              Icons.abc,
                              color: primaryOrange,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryOrange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryOrange),
                            ),
                            labelStyle: TextStyle(color: primaryOrange),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Kalem adı boş bırakılamaz";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          autocorrect: false,
                          cursorColor: primaryOrange,
                          controller: _tutarController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                              label: Text("Tutar"),
                              icon: Icon(
                                Icons.currency_lira,
                                color: primaryOrange,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              labelStyle: TextStyle(color: primaryOrange)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Tutar boş bırakılamaz";
                            } else if (value.contains(",")) {
                              return "Ondalık basamak için nokta kullanınız";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          autocorrect: false,
                          cursorColor: primaryOrange,
                          keyboardType: TextInputType.datetime,
                          controller: _sonOdemeController,
                          decoration: const InputDecoration(
                              label: Text("Son Ödeme Tarihi"),
                              icon: Icon(
                                Icons.date_range,
                                color: primaryOrange,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              labelStyle: TextStyle(color: primaryOrange)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Son Ödeme Tarihi boş bırakılamaz";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: expenseCategoriesTexts.length,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory =
                                        expenseCategoriesTexts[index];
                                  });
                                },
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        width: 1,
                                        color: expenseCategoriesColors[index]),
                                    color: _selectedCategory ==
                                            expenseCategoriesTexts[index]
                                        ? Colors.orange[100]
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
                                      Text(expenseCategoriesTexts[index]),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 60),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text('Gider Kalemi')),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text(
                                              'Kalem Adı: ${_kalemController.text}'),
                                          Text(
                                              'Tutar : ${_tutarController.text}'),
                                          Text(
                                              'Son Ödeme Tarihi: ${_sonOdemeController.text}'),
                                          Text('Kategori: $_selectedCategory'),
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
                                              child: const Text(
                                                'Düzenle',
                                                style: TextStyle(
                                                    color: primaryRed),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          Center(
                                            child: TextButton(
                                              child: const Text(
                                                'Ekle',
                                                style: TextStyle(
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
                                                  const SnackBar(
                                                      content: Text(
                                                          'Gider Kalemi Eklendi')),
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
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: primaryOrange),
                            ),
                            child: const Center(child: Text("Gider Ekle")),
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
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          autocorrect: false,
                          cursorColor: primaryOrange,
                          controller: _kalemController,
                          decoration: const InputDecoration(
                            label: Text("Gelir Adı"),
                            icon: Icon(
                              Icons.abc,
                              color: primaryOrange,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryOrange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryOrange),
                            ),
                            labelStyle: TextStyle(color: primaryOrange),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Kalem adı boş bırakılamaz";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          autocorrect: false,
                          cursorColor: primaryOrange,
                          controller: _tutarController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                              label: Text("Tutar"),
                              icon: Icon(
                                Icons.currency_lira,
                                color: primaryOrange,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              labelStyle: TextStyle(color: primaryOrange)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Tutar boş bırakılamaz";
                            } else if (value.contains(",")) {
                              return "Ondalık basamak için nokta kullanınız";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          autocorrect: false,
                          cursorColor: primaryOrange,
                          keyboardType: TextInputType.datetime,
                          controller: _sonOdemeController,
                          decoration: const InputDecoration(
                              label: Text("Gelir Tarihi"),
                              icon: Icon(
                                Icons.date_range,
                                color: primaryOrange,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryOrange),
                              ),
                              labelStyle: TextStyle(color: primaryOrange)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Son Ödeme Tarihi boş bırakılamaz";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 90, right: 90, top: 130),
                        child: InkWell(
                          onTap: () {
                            if (_formKey2.currentState!.validate()) {
                              showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text('Gider Kalemi')),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
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
                                              child: const Text(
                                                'Düzenle',
                                                style: TextStyle(
                                                    color: primaryRed),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          Center(
                                            child: TextButton(
                                              child: const Text(
                                                'Ekle',
                                                style: TextStyle(
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
                                                  const SnackBar(
                                                      content: Text(
                                                          'Gelir Eklendi')),
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
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: primaryOrange),
                            ),
                            child: const Center(child: Text("Gelir Ekle")),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
