import 'package:flutter/material.dart';
import 'package:greenaccount/pages/income_expense_page/widgets/title_widget.dart';
import 'package:greenaccount/utils/colors.dart';
import 'package:greenaccount/utils/expense_categories.dart';

class IncomeExpensePage extends StatefulWidget {
  const IncomeExpensePage({Key? key}) : super(key: key);

  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  bool isChecked = false;
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
                        children: const [
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                "10.000,00 ₺",
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
                                "2.500,00 ₺",
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
                                "7.500,00 ₺",
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
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: expenseCategoriesColors[index]),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                      height: 460,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 0.5, color: Colors.black),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.apartment),
                              title: Text("YKB Koç Ailem KK\n15.000,00 ₺"),
                              subtitle: Text("Son ödeme tarihi: 10-10-2020"),
                              trailing: Checkbox(
                                  fillColor: MaterialStateProperty.all(primaryOrange),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = !isChecked;
                                    });
                                  }),
                            ),
                          ),
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
