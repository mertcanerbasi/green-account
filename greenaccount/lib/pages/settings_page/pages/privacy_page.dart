import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/language_model.dart';
import '../../../models/theme_model.dart';

import '../../../utils/colors.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: languageNotifier.lang == "en"
              ? const Text("Terms of Privacy")
              : const Text("Gizlilik Şartları"),
          centerTitle: true,
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
        ),
        body: Center(
            child: languageNotifier.lang == "en"
                ? const Text("Terms of Privacy Page to be added")
                : const Text("Gizlilik Şartları Sayfası Eklenecek")),
      );
    });
  }
}
