import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenaccount/pages/create_balance/create_balance_page.dart';
import 'package:greenaccount/pages/history_page/history_page.dart';
import 'package:greenaccount/pages/income_expense_page/income_expense_page.dart';
import 'package:greenaccount/pages/settings_page/settings_page.dart';
import 'package:greenaccount/pages/summary_page/summary_page.dart';
import 'package:greenaccount/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activePage = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'M&M Bank',
          style: GoogleFonts.genos(
            fontSize: 25,
          ),
        ),
        actions: [Center(child: Text(DateTime.now().toString().substring(0, 10) + "  "))],
        backgroundColor: primaryOrange,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _activePage = value;
          });
        },
        children: const [
          SummaryPage(),
          IncomeExpensePage(),
          EditBalancePage(),
          HistoryPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activePage,
        selectedItemColor: primaryOrange,
        unselectedItemColor: Colors.grey[500],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Hesap Ozeti'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Düzenle'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Geçmiş'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ayarlar'),
        ],
        onTap: (value) {
          setState(() {
            _activePage = value;
            _pageController?.jumpToPage(_activePage);
          });
        },
      ),
    );
  }
}
