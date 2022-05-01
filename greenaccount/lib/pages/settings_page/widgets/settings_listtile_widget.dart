import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/theme_model.dart';
import '../../../utils/adaptivescreensize.dart';
import '../../../utils/adaptivetextsize.dart';

class SettingsListTileWidget extends StatefulWidget {
  final String text;
  final Function()? function;
  final Icon icon;
  const SettingsListTileWidget(
      {Key? key, required this.text, this.function, required this.icon})
      : super(key: key);

  @override
  State<SettingsListTileWidget> createState() => _SettingsListTileWidgetState();
}

class _SettingsListTileWidgetState extends State<SettingsListTileWidget> {
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
        child: InkWell(
          onTap: widget.function,
          child: ListTile(
            iconColor: Colors.black,
            leading: widget.icon,
            title: Text(
              widget.text,
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
      );
    });
  }
}
