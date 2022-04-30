import 'package:flutter/material.dart';
import 'package:greenaccount/models/language_model.dart';
import 'package:greenaccount/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'models/theme_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(
          create: (context) => ThemeModel(),
        ),
        ChangeNotifierProvider<LanguageModel>(
          create: (context) => LanguageModel(),
        )
      ],
      child: Consumer2<ThemeModel, LanguageModel>(
          builder: (context, themeNotifier, languageNotifier, widget) {
        return MaterialApp(
          title: 'M&M Bank',
          theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      }),
    );
  }
}
