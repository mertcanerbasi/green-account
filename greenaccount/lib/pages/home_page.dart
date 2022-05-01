import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenaccount/pages/history_page/history_page.dart';
import 'package:greenaccount/pages/income_expense_page/income_expense_page.dart';
import 'package:greenaccount/pages/settings_page/settings_page.dart';
import 'package:greenaccount/pages/summary_page/summary_page.dart';
import 'package:greenaccount/utils/adaptivetextsize.dart';
import 'package:greenaccount/utils/colors.dart';
import 'package:provider/provider.dart';
import '../models/language_model.dart';
import '../models/theme_model.dart';
import 'edit_balance/edit_balance_page.dart';

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
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'M&M Bank',
            style: GoogleFonts.genos(
              fontSize:
                  const AdaptiveTextSize().getadaptiveTextSize(context, 25),
            ),
          ),
          actions: [
            Center(
                child: Text(DateTime.now().toString().substring(0, 10) + "  "))
          ],
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
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
          elevation: 5,
          currentIndex: _activePage,
          type: BottomNavigationBarType.shifting,
          backgroundColor: primaryOrange,
          selectedItemColor: primaryOrange,
          unselectedItemColor: Colors.grey[500],
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: languageNotifier.lang == "en" ? 'Home' : 'Anasayfa'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.receipt),
                label: languageNotifier.lang == "en" ? 'Details' : 'Detaylar'),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.history),
                label: languageNotifier.lang == "en" ? 'History' : 'Geçmiş'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: languageNotifier.lang == "en" ? 'Settings' : 'Ayarlar'),
          ],
          onTap: (value) {
            setState(() {
              _activePage = value;
              _pageController?.jumpToPage(_activePage);
            });
          },
        ),
      );
    });
  }
}
