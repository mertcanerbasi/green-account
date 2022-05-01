import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/language_model.dart';
import '../../../models/theme_model.dart';

import '../../../utils/colors.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: languageNotifier.lang == "en"
              ? const Text("About App")
              : const Text("Uygulama Hakkında"),
          centerTitle: true,
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
        ),
        body: Center(
            child: languageNotifier.lang == "en"
                ? const Text("About App to be added")
                : const Text("Uygulama Hakkında Sayfası Eklenecek")),
      );
    });
  }
}
