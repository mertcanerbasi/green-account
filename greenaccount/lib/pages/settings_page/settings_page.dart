import 'package:flutter/material.dart';
import 'package:greenaccount/pages/settings_page/pages/about_app_page.dart';
import 'package:greenaccount/pages/settings_page/pages/clear_data_page.dart';
import 'package:greenaccount/pages/settings_page/pages/help_page.dart';
import 'package:greenaccount/pages/settings_page/pages/language_selection_page.dart';
import 'package:greenaccount/pages/settings_page/pages/app_lock_page.dart';
import 'package:greenaccount/pages/settings_page/pages/privacy_page.dart';
import 'package:greenaccount/pages/settings_page/pages/share_page.dart';
import 'package:greenaccount/pages/settings_page/widgets/settings_listtile_widget.dart';
import 'package:greenaccount/pages/settings_page/widgets/settings_switchtile_widget.dart';
import 'package:provider/provider.dart';
import '../../models/language_model.dart';
import '../../models/theme_model.dart';
import '../../utils/adaptivescreensize.dart';
import '../../utils/adaptivetextsize.dart';

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppLockPage(),
                  ));
            },
            icon: Icon(
              Icons.security_outlined,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: const AdaptiveScreenSize()
                    .getadaptiveScreenSizeHeight(context, 10),
                bottom: const AdaptiveScreenSize()
                    .getadaptiveScreenSizeHeight(context, 10)),
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
                  style: TextStyle(
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, 20)),
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
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPage(),
                  ));
            },
            icon: Icon(
              Icons.privacy_tip_outlined,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: const AdaptiveScreenSize()
                    .getadaptiveScreenSizeHeight(context, 10),
                bottom: const AdaptiveScreenSize()
                    .getadaptiveScreenSizeHeight(context, 10)),
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
                  style: TextStyle(
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, 20)),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpPage(),
                  ));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutAppPage(),
                  ));
            },
            icon: Icon(
              Icons.info_outline,
              color: themeNotifier.isDark ? Colors.white : Colors.black,
            ),
          ),
          SettingsListTileWidget(
            text: languageNotifier.lang == "en" ? "Share" : "Paylaş",
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SharePage(),
                  ));
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
