import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/language_model.dart';
import '../../../models/theme_model.dart';

import '../../../utils/colors.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: languageNotifier.lang == "en"
              ? const Text("Help Page")
              : const Text("Yardım"),
          centerTitle: true,
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
        ),
        body: Center(
            child: languageNotifier.lang == "en"
                ? const Text("Help Page to be added")
                : const Text("Yardım Sayfası Eklenecek")),
      );
    });
  }
}
