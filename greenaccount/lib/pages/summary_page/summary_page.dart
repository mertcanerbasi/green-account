import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../../models/barchart_model.dart';
import '../../models/income_expense_model.dart';
import '../../models/language_model.dart';
import '../../models/theme_model.dart';
import '../../services/sharedPref.dart';
import '../../utils/colors.dart';
import '../../utils/months_years.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final DataService _dataService = DataService();
  List<IncomeExpenseModel>? expenseList = [];
  List<IncomeExpenseModel>? _incomesList = [];
  Map<String, double> dataMap = {};
  bool _isLoading = true;
  final oCcy = NumberFormat("#,##0.00", "en_EN");
  double _debtAmount = 0;
  double _paidAmount = 0;
  double _incomeAmount = 0;
  double _remainingAmount = 0;
  double _savingsAmount = 0;
  String _selectedChart = 'Category';
  Map<String, double> emptydataMap = {
    "Gider Girilmedi": 1,
  };

  // List of items in our dropdown menu

  void _readExpenseList() async {
    List<IncomeExpenseModel>? list = await _dataService.readExpenseList();
    setState(() {
      expenseList = list;
      expenseList?.forEach((element) {
        dataMap.addAll(element.toPieChartMap());
        if (!element.isGelir) {
          _debtAmount += element.miktar;
          _paidAmount += element.isOdendi == true ? element.miktar : 0;
        }

        if (element.kategori == "Birikim") {
          _savingsAmount += element.miktar;
        }
        _remainingAmount = _debtAmount - _paidAmount;
      });
    });
  }

  void _readIncomesList() async {
    List<IncomeExpenseModel>? list = await _dataService.readIncomeList();
    setState(() {
      _incomesList = list;
      _incomesList?.forEach((element) {
        if (element.isGelir) {
          _incomeAmount += element.miktar;
        }
      });
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    _readExpenseList();
    _readIncomesList();
  }

  @override
  Widget build(BuildContext context) {
    final List<IncomeExpense> data = [
      IncomeExpense(
          "Gelir",
          _incomeAmount - _debtAmount <= 0 ? _incomeAmount : _debtAmount,
          "Gelir"),
      IncomeExpense(
          "Gelir",
          _incomeAmount - _debtAmount <= 0 ? 0 : _incomeAmount - _debtAmount,
          "Kalan Nakit"),
      IncomeExpense("Gider", _paidAmount, "Ödenen"),
      IncomeExpense("Gider", _remainingAmount, "Gider"),
    ];
    List<charts.Series<IncomeExpense, String>> series = [
      charts.Series(
          id: "IncomeExpenseChart",
          data: data,
          domainFn: (IncomeExpense series, _) => series.type,
          measureFn: (IncomeExpense series, _) => series.expense,
          colorFn: (IncomeExpense segment, _) {
            switch (segment.name) {
              case "Gelir":
                {
                  return charts.ColorUtil.fromDartColor(primaryGreen);
                }

              case "Kalan Nakit":
                {
                  return charts.ColorUtil.fromDartColor(secondaryGreen);
                }

              case "Gider":
                {
                  return charts.ColorUtil.fromDartColor(secondaryRed);
                }

              case "Ödenen":
                {
                  return charts.ColorUtil.fromDartColor(primaryYellow);
                }

              default:
                {
                  return charts.MaterialPalette.red.shadeDefault;
                }
            }
          },
          displayName: "Asd")
    ];

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Consumer2<ThemeModel, LanguageModel>(builder: (context,
            ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
            String dropdownValueMonth =
                languageNotifier.lang == "en" ? 'January' : "Ocak";
            String dropdownValueYear = DateTime.now().year.toString();

            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Spacer(),
                        Center(
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: primaryOrange),
                            ),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(20),
                                  value: dropdownValueMonth,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: languageNotifier.lang == "en"
                                      ? monthsEn.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList()
                                      : months.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueMonth = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1, color: primaryOrange),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 3,
                                borderRadius: BorderRadius.circular(20),
                                value: dropdownValueYear,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: years.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueYear = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.currency_lira_outlined,
                      color: Colors.green,
                    ),
                    title: languageNotifier.lang == "en"
                        ? const Text("Total Income")
                        : const Text("Toplam Gelir"),
                    trailing: Text(
                      "${oCcy.format(_incomeAmount)} ₺",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.currency_lira_outlined,
                      color: Colors.red,
                    ),
                    title: languageNotifier.lang == "en"
                        ? const Text("Total Expense")
                        : const Text("Toplam Gider"),
                    trailing: Text(
                      "${oCcy.format(_debtAmount)} ₺",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.currency_lira_outlined,
                      color: Colors.yellow[700],
                    ),
                    title: languageNotifier.lang == "en"
                        ? const Text("Paid Expenses")
                        : const Text("Ödenen Gider"),
                    trailing: Text(
                      "${oCcy.format(_paidAmount)} ₺",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.currency_lira_outlined,
                      color: secondaryRed,
                    ),
                    title: languageNotifier.lang == "en"
                        ? const Text("Remained Expense")
                        : const Text("Kalan Gider"),
                    trailing: Text(
                      "${oCcy.format(_remainingAmount)} ₺",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.currency_lira_outlined,
                      color: secondaryGreen,
                    ),
                    title: languageNotifier.lang == "en"
                        ? const Text("Remained Cash")
                        : const Text("Kalan Nakit"),
                    trailing: Text(
                      "${oCcy.format(_incomeAmount - _debtAmount)} ₺",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.currency_lira_outlined,
                      color: primaryBlue,
                    ),
                    title: languageNotifier.lang == "en"
                        ? const Text("Total Savings")
                        : const Text("Toplam Birikim"),
                    trailing: Text(
                      "${oCcy.format(_savingsAmount)} ₺",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
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
                              _selectedChart = "Category";
                            });
                          },
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(width: 1, color: primaryOrange),
                                color: _selectedChart == "Category"
                                    ? (themeNotifier.isDark
                                        ? Colors.grey[600]
                                        : Colors.orange[50])
                                    : null),
                            child: Center(
                              child: languageNotifier.lang == "en"
                                  ? const Text("Category Details",
                                      style: TextStyle(fontSize: 20))
                                  : const Text("Kategori Detay",
                                      style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedChart = "Income";
                            });
                          },
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(width: 1, color: primaryOrange),
                                color: _selectedChart == "Income"
                                    ? (themeNotifier.isDark
                                        ? Colors.grey[600]
                                        : Colors.orange[50])
                                    : null),
                            child: Center(
                              child: languageNotifier.lang == "en"
                                  ? const Text("Income-Expense",
                                      style: TextStyle(fontSize: 20))
                                  : const Text("Gelir-Gider",
                                      style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                dataMap.isNotEmpty == true && _selectedChart == "Category"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: PieChart(
                          dataMap: dataMap,
                          animationDuration: const Duration(milliseconds: 800),
                          chartLegendSpacing: 50,
                          chartRadius: 200,
                          legendOptions: const LegendOptions(
                              legendTextStyle:
                                  TextStyle(fontWeight: FontWeight.normal)),
                          //colorList: expenseCategoriesColors,
                          chartValuesOptions: const ChartValuesOptions(
                              chartValueStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              decimalPlaces: 2,
                              showChartValuesOutside: true,
                              showChartValuesInPercentage: true,
                              showChartValueBackground: false,
                              showChartValues: false),

                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        ),
                      )
                    : dataMap.isNotEmpty == true && _selectedChart == "Income"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: SizedBox(
                              height: 300,
                              child: charts.BarChart(
                                series,
                                barGroupingType:
                                    charts.BarGroupingType.groupedStacked,
                                animate: true,

                                domainAxis: charts.OrdinalAxisSpec(
                                    renderSpec: charts.SmallTickRendererSpec(

                                        // Tick and Label styling here.
                                        labelStyle: charts.TextStyleSpec(
                                            fontSize: 15, // size in Pts.
                                            color: themeNotifier.isDark
                                                ? charts.MaterialPalette.white
                                                : charts.MaterialPalette.black),

                                        // Change the line colors to match text color.
                                        lineStyle: charts.LineStyleSpec(
                                            color: themeNotifier.isDark
                                                ? charts.MaterialPalette.white
                                                : charts
                                                    .MaterialPalette.black))),

                                /// Assign a custom style for the measure axis.
                                primaryMeasureAxis: charts.NumericAxisSpec(
                                    renderSpec: charts.GridlineRendererSpec(

                                        // Tick and Label styling here.
                                        labelStyle: charts.TextStyleSpec(
                                            fontSize: 15, // size in Pts.
                                            color: themeNotifier.isDark
                                                ? charts.MaterialPalette.white
                                                : charts.MaterialPalette.black),

                                        // Change the line colors to match text color.
                                        lineStyle: charts.LineStyleSpec(
                                            color: themeNotifier.isDark
                                                ? charts.MaterialPalette.white
                                                : charts
                                                    .MaterialPalette.black))),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: PieChart(
                              dataMap: emptydataMap,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 50,
                              chartRadius: 200,
                              centerText: languageNotifier.lang == "en"
                                  ? "No Expense\nEntry"
                                  : "Gider Girilmedi",

                              centerTextStyle: const TextStyle(fontSize: 20),
                              legendOptions:
                                  const LegendOptions(showLegends: false),
                              colorList: const [primaryOrange],
                              //colorList: expenseCategoriesColors,
                              chartValuesOptions: const ChartValuesOptions(
                                chartValueStyle: TextStyle(
                                    fontSize: 10, color: Colors.black),
                                decimalPlaces: 2,
                                showChartValuesOutside: true,
                                showChartValuesInPercentage: true,
                                showChartValues: false,
                                showChartValueBackground: false,
                              ),

                              // gradientList: ---To add gradient colors---
                              // emptyColorGradient: ---Empty Color gradient---
                            ),
                          ),
              ],
            );
          });
  }
}
