import 'package:flutter/material.dart';
import 'package:greenaccount/models/language_model.dart';
import 'package:provider/provider.dart';

import '../../../models/theme_model.dart';
import '../../../utils/colors.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: languageNotifier.lang == "en"
              ? const Text("Language Selection")
              : const Text("Dil Seçimi"),
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
        ),
        body: SingleChildScrollView(
          child: ListBody(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    languageNotifier.lang = "en";
                  });
                },
                child: ListTile(
                  leading: Image.asset(
                    'assets/en.png',
                    height: 25,
                    width: 40,
                  ),
                  title: const Text("English"),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    languageNotifier.lang = "tr";
                  });
                },
                child: ListTile(
                  leading: Image.asset(
                    'assets/tr.png',
                    height: 25,
                    width: 40,
                  ),
                  title: const Text("Türkçe"),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
