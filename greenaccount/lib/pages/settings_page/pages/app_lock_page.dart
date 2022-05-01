import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/language_model.dart';
import '../../../models/theme_model.dart';

import '../../../utils/colors.dart';

class AppLockPage extends StatefulWidget {
  const AppLockPage({Key? key}) : super(key: key);

  @override
  State<AppLockPage> createState() => _AppLockPageState();
}

class _AppLockPageState extends State<AppLockPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: languageNotifier.lang == "en"
              ? const Text("App Lock")
              : const Text("Uygulama Kilidi"),
          centerTitle: true,
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
        ),
        body: Center(
            child: languageNotifier.lang == "en"
                ? const Text("App Lock Page to be added")
                : const Text("Uygulama Kilidi Sayfası Eklenecek")),
      );
    });
  }
}
