import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastPage',
      theme: ThemeData(
        primarySwatch: LastpageColors.white,
        canvasColor: LastpageColors.lightGrey,
        appBarTheme: const AppBarTheme(
          elevation: 1.2,
          backgroundColor: LastpageColors.white,
          iconTheme: IconThemeData(color: LastpageColors.darkGrey),
          titleTextStyle: TextStyle(
              color: LastpageColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: LastpageColors.white,
          iconColor: LastpageColors.darkGrey,
        ),
        shadowColor: LastpageColors.lightGrey,
        primaryColor: LastpageColors.darkGrey,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            // primary: LastpageColors.black,
            secondary: LastpageColors.blue,
            tertiary: LastpageColors.lightGrey),
      ),
      home: const Dashboard(),
    );
  }
}
