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
  List<IncomeExpenseModel>? expensesList = [];
  List<IncomeExpenseModel>? _selectedExpenseList = [];
  final oCcy = NumberFormat("#,##0.00", "tr_TR");
  double _debtAmount = 0;
  double _paidAmount = 0;
  double _remainingAmount = 0;
  String _selectedCategory = "Hepsi";
  final DataService _dataService = DataService();

  _readExpenseList() async {
    List<IncomeExpenseModel>? list = await _dataService.readExpenseList();
    setState(() {
      expensesList = list;
      if (expensesList?.isNotEmpty == true) {
        for (var element in expensesList!) {
          _debtAmount += element.miktar;
          _paidAmount += element.isOdendi == true ? element.miktar : 0;
        }
      }

      _remainingAmount = _debtAmount - _paidAmount;
      _selectedExpenseList = expensesList;
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
                            _selectedCategory == expenseCategoriesTexts[index] ? _selectedCategory = "Hepsi" : _selectedCategory = expenseCategoriesTexts[index];
                            _selectedExpenseList = _selectedCategory == expenseCategoriesTexts[index] ? expensesList?.where((element) => element.kategori == _selectedCategory).toList() : expensesList;
                          });
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1, color: expenseCategoriesColors[index]),
                            color: _selectedCategory == expenseCategoriesTexts[index] ? Colors.orange[100] : null,
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                      height: 460,
                      child: ListView.builder(
                        itemCount: _selectedExpenseList?.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: _selectedExpenseList?.isNotEmpty == true
                              ? Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(width: 0.5, color: Colors.black),
                                  ),
                                  child: ListTile(
                                    leading: _selectedExpenseList?[index].kategori == "Konut"
                                        ? const Icon(
                                            Icons.apartment,
                                            color: primaryOrange,
                                          )
                                        : _selectedExpenseList?[index].kategori == "Fatura"
                                            ? const Icon(
                                                Icons.receipt_long,
                                                color: primaryRed,
                                              )
                                            : _selectedExpenseList?[index].kategori == "Kredi Kartı"
                                                ? const Icon(
                                                    Icons.credit_card,
                                                    color: primaryBlue,
                                                  )
                                                : _selectedExpenseList?[index].kategori == "Birikim"
                                                    ? const Icon(
                                                        Icons.savings_outlined,
                                                        color: primaryPink,
                                                      )
                                                    : const Icon(
                                                        Icons.currency_lira,
                                                        color: primaryBrown,
                                                      ),
                                    title: Text("${_selectedExpenseList?[index].kalemAdi}\n${oCcy.format(_selectedExpenseList?[index].miktar)} ₺"),
                                    subtitle: Text("Son ödeme tarihi: ${_selectedExpenseList?[index].sonOdemeTarihi}"),
                                    trailing: Checkbox(
                                        fillColor: MaterialStateProperty.all(primaryOrange),
                                        value: _selectedExpenseList?[index].isOdendi,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _selectedExpenseList?[index].isOdendi = value;
                                            _selectedExpenseList?[index].isOdendi == false ? _paidAmount -= _selectedExpenseList![index].miktar : _paidAmount += _selectedExpenseList![index].miktar;
                                          });
                                          _updateDebtPaid();
                                        }),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
