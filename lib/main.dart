import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stayhome/data_provider.dart';
import 'package:stayhome/loading_screen.dart';
import 'package:stayhome/screen/home_screen.dart';
import 'package:stayhome/app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _provider = DataProvider();
  Future<Map<String, dynamic>> get data async {
    return {
      'preferences': await SharedPreferences.getInstance(),
      'statistics': await _provider.statistics,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: data,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoaderScreen();
        return App(
          provider: _provider,
          preferences: snapshot.data['preferences'],
          statistics: snapshot.data['statistics'],
          child: MyMaterialApp(),
        );
      },
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: App.of(context).provider.affectedCountries,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoaderScreen();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            appBarTheme: AppBarTheme(
              elevation: 0,
              brightness: Brightness.dark,
            ),
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
