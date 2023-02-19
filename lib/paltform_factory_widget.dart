import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformFactoryWidget extends StatelessWidget {
  const PlatformFactoryWidget(
      {super.key,
      required this.androidBuilder,
      required this.iOsWidgetBuilder});

  final WidgetBuilder androidBuilder;
  final WidgetBuilder iOsWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iOsWidgetBuilder(context);
      default:
        return const SizedBox.shrink();
    }
  }
}
