import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:greenaccount/pages/settings_page/pages/clear_data_page.dart';
import 'package:greenaccount/pages/settings_page/pages/language_selection_page.dart';
import 'package:greenaccount/pages/settings_page/widgets/settings_listtile_widget.dart';
import 'package:greenaccount/pages/settings_page/widgets/settings_switchtile_widget.dart';
import 'package:provider/provider.dart';
import '../../models/language_model.dart';
import '../../models/theme_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LanguageModel>(builder: (context,
        ThemeModel themeNotifier, LanguageModel languageNotifier, child) {
      return ListView(
        children: [
          SettingsSwitchTileWidget(
              text: languageNotifier.lang == "en"
                  ? "Dark Theme"
                  : "Karanlık Tema"),
          SettingsListTileWidget(
            text:
                languageNotifier.lang == "en" ? "App Lock" : "Uygulama Kilidi",
            function: () {
              log("TODO : Uygulama Kilidi Bölümü Eklenecek");
            },
            icon: Icon(
              Icons.security_outlined,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClearDataPage(),
                    ));
              },
              child: ListTile(
                iconColor: Colors.black,
                leading: Icon(Icons.cleaning_services,
                    color: themeNotifier.isDark ? Colors.white : Colors.black),
                title: Text(
                  languageNotifier.lang == "en"
                      ? "Clear Data"
                      : "Verileri temizle",
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.adaptive.arrow_forward,
                  color: themeNotifier.isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          SettingsListTileWidget(
            text: languageNotifier.lang == "en"
                ? "Terms of Privacy"
                : "Gizlilik Şartları",
            function: null,
            icon: Icon(
              Icons.privacy_tip_outlined,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageSelectionPage(),
                    ));
              },
              child: ListTile(
                iconColor: Colors.black,
                leading: Icon(
                  Icons.language,
                  color: themeNotifier.isDark ? Colors.white : Colors.black,
                ),
                title: Text(
                  languageNotifier.lang == "en" ? "Language" : "Dil",
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.adaptive.arrow_forward,
                  color: themeNotifier.isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          SettingsListTileWidget(
            text: languageNotifier.lang == "en" ? "Help" : "Yardım",
            function: () {
              log("TODO : Destek Bölümü Eklenecek");
            },
            icon: Icon(
              Icons.support_outlined,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
          SettingsListTileWidget(
            text: languageNotifier.lang == "en"
                ? "About App"
                : "Uygulama Hakkında",
            function: () {
              log("TODO : Hakkında Bölümü Eklenecek");
            },
            icon: Icon(
              Icons.info_outline,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
          SettingsListTileWidget(
            text: languageNotifier.lang == "en" ? "Share" : "Paylaş",
            function: () {
              log("TODO : Paylaş Bölümü Eklenecek");
            },
            icon: Icon(
              Icons.share_outlined,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      );
    });
  }
}
