import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/theme_model.dart';
import '../../../utils/adaptivescreensize.dart';
import '../../../utils/adaptivetextsize.dart';

class SettingsSwitchTileWidget extends StatefulWidget {
  final String text;
  const SettingsSwitchTileWidget({Key? key, required this.text})
      : super(key: key);

  @override
  State<SettingsSwitchTileWidget> createState() =>
      _SettingsSwitchTileWidgetState();
}

class _SettingsSwitchTileWidgetState extends State<SettingsSwitchTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return Padding(
        padding: EdgeInsets.only(
            top: const AdaptiveScreenSize()
                .getadaptiveScreenSizeHeight(context, 10),
            bottom: const AdaptiveScreenSize()
                .getadaptiveScreenSizeHeight(context, 10)),
        child: ListTile(
          iconColor: themeNotifier.isDark ? Colors.white : Colors.black,
          leading: const Icon(Icons.color_lens),
          title: Text(
            widget.text,
            style: TextStyle(
                fontSize:
                    const AdaptiveTextSize().getadaptiveTextSize(context, 20)),
          ),
          trailing: Switch.adaptive(
              activeColor: Colors.black,
              value: themeNotifier.isDark,
              onChanged: (value) async {
                setState(() {
                  themeNotifier.isDark = value;
                });
              }),
        ),
      );
    });
  }
}
