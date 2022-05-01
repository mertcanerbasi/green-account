import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/language_model.dart';
import '../../../models/theme_model.dart';

import '../../../utils/colors.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: languageNotifier.lang == "en"
              ? const Text("Share")
              : const Text("Paylaş"),
          centerTitle: true,
          backgroundColor:
              themeNotifier.isDark ? Colors.black12 : primaryOrange,
        ),
        body: Center(
            child: languageNotifier.lang == "en"
                ? const Text("Share to be added")
                : const Text("Paylaş Sayfası Eklenecek")),
      );
    });
  }
}
