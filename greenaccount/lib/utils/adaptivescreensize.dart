import 'package:flutter/material.dart';

class AdaptiveScreenSize {
  const AdaptiveScreenSize();

  getadaptiveScreenSizeHeight(BuildContext context, dynamic value) {
    return ((value / 926) * MediaQuery.of(context).size.height);
  }

  getadaptiveScreenSizeWidth(BuildContext context, dynamic value) {
    return ((value / 428) * MediaQuery.of(context).size.width);
  }
}
