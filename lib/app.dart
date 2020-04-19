import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stayhome/data_provider.dart';

class App extends InheritedWidget {
  final SharedPreferences preferences;
  final DataProvider provider;
  final List statistics;

  App({this.statistics, this.provider, this.preferences, Widget child})
      : super(child: child);

  Map<String, dynamic> get currentCountry {
    final rawData = preferences.getString('currentCountry');
    if (rawData == null) return statistics.first;
    return json.decode(rawData);
  }

  set currentCountry(Map<String, dynamic> value) {
    preferences.setString('currentCountry', json.encode(value));
  }

  List<Map<String, String>> symptoms = [
    {
      'picture': 'symptom1',
      'title': '',
      'description': '',
    },
    {
      'picture': 'symptom2',
      'title': '',
      'description': '',
    },
    {
      'picture': 'symptom3',
      'title': '',
      'description': '',
    },
    {
      'picture': 'symptom4',
      'title': '',
      'description': '',
    },
    {
      'picture': 'symptom5',
      'title': '',
      'description': '',
    },
  ];

  static App of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<App>();
  }

  refreshStats(List value) {
    statistics
      ..clear()
      ..add(value);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
