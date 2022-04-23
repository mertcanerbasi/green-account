import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../income_expense_page/widgets/title_widget.dart';

class EditBalancePage extends StatefulWidget {
  const EditBalancePage({Key? key}) : super(key: key);

  @override
  State<EditBalancePage> createState() => _EditBalancePageState();
}

class _EditBalancePageState extends State<EditBalancePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Edit Page"),
    );
  }
}
