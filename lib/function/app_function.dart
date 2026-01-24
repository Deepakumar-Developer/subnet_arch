import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subnet_arch/widget/sn_text.dart';

double height(BuildContext context) => MediaQuery.of(context).size.height;

double width(BuildContext context) => MediaQuery.of(context).size.width;

String appName = 'Subnet Arch';

Map<String, dynamic> data =
{'ip':'192.168.120.5', 'by':'mask', 'sn':'', 'mask':'24', 'host':'', 'name' : 'Sample_testing', 'time': 12487894613};

void customStatusBar(Color statusBarColor, Color systemNavigationBarColor,
    Brightness statusBarIconBrightness, Brightness systemNavigationBarIconBrightness) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: statusBarIconBrightness,
    systemNavigationBarColor: systemNavigationBarColor,
    systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
  ));
}

class SnPadding {
  static const EdgeInsets pagePadding = EdgeInsets.all(24);
  static const EdgeInsets innerPadding = EdgeInsets.all(12);
  static const EdgeInsets elementGap = EdgeInsets.only(bottom: 12);
  static const EdgeInsets sectionGap = EdgeInsets.symmetric(vertical: 20);
}

void showToast(String str, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      duration: Duration(milliseconds: 500),
      content: SnSubTitle(str),
    ),
  );
}