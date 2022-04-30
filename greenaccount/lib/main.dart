import 'package:flutter/material.dart';
import 'package:greenaccount/models/app_preferences_model.dart';
import 'package:greenaccount/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppPreferencesModel(),
      child: const MaterialApp(
        title: 'M&M Bank',
        home: HomePage(),
      ),
    );
  }
}
