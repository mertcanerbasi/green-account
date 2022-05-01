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
import '../../utils/adaptivescreensize.dart';
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
  List<IncomeExpenseModel>? _selectedExpenseList = [];
  List<IncomeExpenseModel>? _incomesList = [];
  List<IncomeExpenseModel>? _selectedIncomesList = [];
  Map<String, double> dataMap = {};
  bool _isLoading = true;
  final oCcy = NumberFormat("#,##0.00", "en_EN");
  double _debtAmount = 0;
  double _paidAmount = 0;
  double _incomeAmount = 0;
  double _remainingAmount = 0;
  double _savingsAmount = 0;
  String _selectedChart = 'Category';
  int monthIndex = DateTime.now().month - 1;
  int yearIndex = DateTime.now().year - 2021;
  Map<String, double> emptydataMap = {
    "Gider Girilmedi": 1,
  };

  void _readExpenseList() async {
    List<IncomeExpenseModel>? list = await _dataService.readExpenseList();
    String _language = await LanguageModel().getPreferences();
    setState(() {
      expenseList = list;
      _debtAmount = 0;
      _paidAmount = 0;
      _savingsAmount = 0;
      _remainingAmount = 0;
      dataMap.clear();
      _selectedExpenseList = expenseList
          ?.where((element) =>
              (int.parse(element.sonOdemeTarihi.substring(3, 5)) - 1 ==
                      monthIndex &&
                  int.parse(element.sonOdemeTarihi.substring(6, 10)) - 2021 ==
                      yearIndex))
          .toList();

      _selectedExpenseList?.forEach((element) {
        dataMap.addAll(element.toPieChartMap(_language));
        if (!element.isGelir) {
          _debtAmount += element.miktar;
          _paidAmount += element.isOdendi == true ? element.miktar : 0;
        }

        if (element.kategori == "Birikim") {
          _savingsAmount += element.miktar;
        }
        _remainingAmount = _debtAmount - _paidAmount;
      });
      _isLoading = false;
    });
  }

  void _readIncomesList() async {
    List<IncomeExpenseModel>? list = await _dataService.readIncomeList();
    setState(() {
      _incomesList = list;
      _incomeAmount = 0;
      _selectedIncomesList = _incomesList
          ?.where((element) =>
              (int.parse(element.sonOdemeTarihi.substring(3, 5)) - 1 ==
                      monthIndex &&
                  int.parse(element.sonOdemeTarihi.substring(6, 10)) - 2021 ==
                      yearIndex))
          .toList();
      _selectedIncomesList?.forEach((element) {
        if (element.isGelir) {
          _incomeAmount += element.miktar;
        }
      });
      _isLoading = false;
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
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Consumer2<ThemeModel, LanguageModel>(builder: (context,
            ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
            final List<IncomeExpense> data = [
              IncomeExpense(
                  languageNotifier.lang == "en" ? "Income" : "Gelir",
                  _incomeAmount - _debtAmount <= 0
                      ? _incomeAmount
                      : _debtAmount,
                  "Gelir"),
              IncomeExpense(
                  languageNotifier.lang == "en" ? "Income" : "Gelir",
                  _incomeAmount - _debtAmount <= 0
                      ? 0
                      : _incomeAmount - _debtAmount,
                  "Kalan Nakit"),
              IncomeExpense(languageNotifier.lang == "en" ? "Expense" : "Gider",
                  _paidAmount, "Ödenen"),
              IncomeExpense(languageNotifier.lang == "en" ? "Income" : "Gider",
                  _remainingAmount, "Gider"),
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

            return ListView(
              children: [
                SizedBox(
                  height: const AdaptiveScreenSize()
                      .getadaptiveScreenSizeHeight(context, 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: const AdaptiveScreenSize()
                        .getadaptiveScreenSizeHeight(context, 50),
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Spacer(),
                        Center(
                          child: Container(
                            width: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeWidth(context, 150),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  const AdaptiveScreenSize()
                                      .getadaptiveScreenSizeHeight(
                                          context, 10))),
                              border:
                                  Border.all(width: 1, color: primaryOrange),
                            ),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(
                                      const AdaptiveScreenSize()
                                          .getadaptiveScreenSizeHeight(
                                              context, 20)),
                                  value: languageNotifier.lang == "en"
                                      ? monthsEn[monthIndex]
                                      : months[monthIndex],
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: languageNotifier.lang == "en"
                                      ? monthsEn.map((String items) {
                                          return DropdownMenuItem(
                                            onTap: () {},
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
                                  onChanged: (String? newValue) async {
                                    setState(() {
                                      monthIndex = languageNotifier.lang == "en"
                                          ? monthsEn.indexOf(newValue!)
                                          : months.indexOf(newValue!);
                                    });
                                    _readIncomesList();
                                    _readExpenseList();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: const AdaptiveScreenSize()
                              .getadaptiveScreenSizeWidth(context, 30),
                        ),
                        Center(
                          child: Container(
                            width: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeWidth(context, 150),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  const AdaptiveScreenSize()
                                      .getadaptiveScreenSizeHeight(
                                          context, 10))),
                              border:
                                  Border.all(width: 1, color: primaryOrange),
                            ),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(
                                      const AdaptiveScreenSize()
                                          .getadaptiveScreenSizeHeight(
                                              context, 20)),
                                  value: years[yearIndex],

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
                                  onChanged: (String? newValue) async {
                                    setState(() {
                                      yearIndex = years.indexOf(newValue!);
                                    });
                                    _readIncomesList();
                                    _readExpenseList();
                                  },
                                ),
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
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedChart = "Category";
                            });
                          },
                          child: Container(
                            width: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeWidth(context, 180),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeHeight(
                                            context, 10))),
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
                        SizedBox(
                          width: const AdaptiveScreenSize()
                              .getadaptiveScreenSizeWidth(context, 40),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedChart = "Income";
                            });
                          },
                          child: Container(
                            width: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeWidth(context, 180),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    const AdaptiveScreenSize()
                                        .getadaptiveScreenSizeHeight(
                                            context, 10))),
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
                        padding: EdgeInsets.symmetric(
                            vertical: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeHeight(context, 20),
                            horizontal: const AdaptiveScreenSize()
                                .getadaptiveScreenSizeWidth(context, 10)),
                        child: PieChart(
                          dataMap: dataMap,
                          animationDuration: const Duration(milliseconds: 800),
                          chartLegendSpacing: const AdaptiveScreenSize()
                              .getadaptiveScreenSizeHeight(context, 50),
                          chartRadius: const AdaptiveScreenSize()
                              .getadaptiveScreenSizeHeight(context, 200),
                          legendOptions: LegendOptions(
                              showLegends: true,
                              legendTextStyle: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              legendLabels: languageNotifier.lang == "en"
                                  ? {
                                      "Kredi Kartı": "Credit Card",
                                      "Fatura": "Bills"
                                    }
                                  : {}),
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
                            padding: EdgeInsets.symmetric(
                                vertical: const AdaptiveScreenSize()
                                    .getadaptiveScreenSizeHeight(context, 20),
                                horizontal: const AdaptiveScreenSize()
                                    .getadaptiveScreenSizeHeight(context, 10)),
                            child: SizedBox(
                              height: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 300),
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
                            padding: EdgeInsets.all(const AdaptiveScreenSize()
                                .getadaptiveScreenSizeHeight(context, 10)),
                            child: PieChart(
                              dataMap: emptydataMap,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 50),
                              chartRadius: const AdaptiveScreenSize()
                                  .getadaptiveScreenSizeHeight(context, 200),
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
