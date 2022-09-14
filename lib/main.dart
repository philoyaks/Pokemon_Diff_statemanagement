import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/constants/app_theme.dart';
import 'package:pokedex/screens/Home_screen/home_screen.dart';
import 'package:pokedex/services/storage/storage_services.dart';

void main() async {
  await AppStorage().initializeHiveParameters();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppThemeData.appThemeData,
      home: const MyHomePage(),
    );
  }
}
