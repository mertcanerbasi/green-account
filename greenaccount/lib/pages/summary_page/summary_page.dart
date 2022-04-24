import 'package:flutter/material.dart';
import '../../services/sharedPref.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final DataService _dataService = DataService();

  _readExpenseList() async {
    await _dataService.clearExpenseList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text("Özet Sayfası"),
        ),
        InkWell(
          onTap: _readExpenseList,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.red,
            child: const Center(child: Text("Temizle")),
          ),
        )
      ],
    );
  }
}
