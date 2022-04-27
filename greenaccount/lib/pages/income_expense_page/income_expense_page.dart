import 'package:flutter/material.dart';
import 'package:greenaccount/models/income_expense_model.dart';
import 'package:greenaccount/utils/colors.dart';
import 'package:greenaccount/utils/expense_categories.dart';
import 'package:intl/intl.dart';
import '../../services/sharedPref.dart';

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
  final DataService _dataService = DataService();

  Future<void> _writeToExpenseList() async {
    await _dataService.writeExpenseList(_expensesList);
  }

  Future<void> _readExpenseList() async {
    List<IncomeExpenseModel>? list = await _dataService.readExpenseList();
    setState(() {
      _expensesList = list;
      if (_expensesList?.isNotEmpty == true) {
        for (var element in _expensesList!) {
          _debtAmount += element.miktar;
          _paidAmount += element.isOdendi == true ? element.miktar : 0;
        }
      }

      _remainingAmount = _debtAmount - _paidAmount;
      _selectedExpenseList = _expensesList;
    });
  }

  @override
  void initState() {
    super.initState();
    _readExpenseList();
  }

  _updateDebtPaid() {
    setState(() {
      _remainingAmount = _debtAmount - _paidAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                "Borç",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: primaryOrange,
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                "Ödenen",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: primaryOrange,
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                "Kalan",
                                textAlign: TextAlign.start,
                                style: TextStyle(
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
                            width: 100,
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
                            width: 100,
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
                            width: 100,
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: expenseCategoriesTexts.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedCategory == expenseCategoriesTexts[index]
                                ? _selectedCategory = "Hepsi"
                                : _selectedCategory =
                                    expenseCategoriesTexts[index];
                            _selectedExpenseList = _selectedCategory ==
                                    expenseCategoriesTexts[index]
                                ? _expensesList
                                    ?.where((element) =>
                                        element.kategori == _selectedCategory)
                                    .toList()
                                : _expensesList;
                          });
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                _selectedExpenseList?.isNotEmpty == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                            height: 460,
                            child: ListView.builder(
                              itemCount: _selectedExpenseList?.length,
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    onLongPress: () {
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
                                                      child: const Text(
                                                        'Sil',
                                                        style: TextStyle(
                                                            color: primaryRed),
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          _debtAmount =
                                                              _debtAmount -
                                                                  _expensesList![
                                                                          index]
                                                                      .miktar;
                                                          _expensesList![index]
                                                                      .isOdendi ==
                                                                  true
                                                              ? _paidAmount =
                                                                  _paidAmount -
                                                                      _expensesList![
                                                                              index]
                                                                          .miktar
                                                              : _paidAmount;
                                                          _expensesList!
                                                              .removeAt(index);
                                                        });

                                                        Navigator.pop(context);

                                                        setState(() {
                                                          _writeToExpenseList()
                                                              .then((value) =>
                                                                  _readExpenseList());
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Center(
                                                    child: TextButton(
                                                      child: const Text(
                                                        'Ekle',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      onPressed: () async {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  'Gider Kalemi Eklendi')),
                                                        );
                                                        Navigator.of(context)
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
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 0.5, color: Colors.black),
                                      ),
                                      child: ListTile(
                                        leading: _selectedExpenseList?[index]
                                                    .kategori ==
                                                "Konut"
                                            ? const Icon(
                                                Icons.apartment,
                                                color: primaryOrange,
                                              )
                                            : _selectedExpenseList?[index]
                                                        .kategori ==
                                                    "Fatura"
                                                ? const Icon(
                                                    Icons.receipt_long,
                                                    color: primaryRed,
                                                  )
                                                : _selectedExpenseList?[index]
                                                            .kategori ==
                                                        "Kredi Kartı"
                                                    ? const Icon(
                                                        Icons.credit_card,
                                                        color: primaryBlue,
                                                      )
                                                    : _selectedExpenseList?[
                                                                    index]
                                                                .kategori ==
                                                            "Birikim"
                                                        ? const Icon(
                                                            Icons
                                                                .savings_outlined,
                                                            color: primaryPink,
                                                          )
                                                        : const Icon(
                                                            Icons.currency_lira,
                                                            color: primaryBrown,
                                                          ),
                                        title: Text(
                                            "${_selectedExpenseList?[index].kalemAdi}\n${oCcy.format(_selectedExpenseList?[index].miktar)} ₺"),
                                        subtitle: Text(
                                            "Son ödeme tarihi: ${_selectedExpenseList?[index].sonOdemeTarihi}"),
                                        trailing: Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    primaryOrange),
                                            value: _selectedExpenseList?[index]
                                                .isOdendi,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _selectedExpenseList?[index]
                                                    .isOdendi = value;
                                                _selectedExpenseList?[index]
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
                                                _expensesList?[index].isOdendi =
                                                    value;
                                                _writeToExpenseList();
                                              });
                                              _updateDebtPaid();
                                            }),
                                      ),
                                    ),
                                  )),
                            )),
                      )
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "Henüz bir gider girmediniz",
                              style: TextStyle(fontSize: 20),
                            )),
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
