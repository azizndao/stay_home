import 'package:flutter/foundation.dart';

class Statistic {
  final String country;
  final int newsCases;
  final int activesCases;
  final int criticalsCases;
  final int recovereds;
  final int totalCases;
  final int newDeaths;
  final int totalDeaths;
  final int totalTests;
  final DateTime time;

  const Statistic({
    @required this.country,
    @required this.newsCases,
    @required this.activesCases,
    @required this.criticalsCases,
    @required this.recovereds,
    @required this.totalCases,
    @required this.newDeaths,
    @required this.totalDeaths,
    @required this.totalTests,
    @required this.time,
  });

  static Statistic parse(Map<String, dynamic> data) {
    return Statistic(
      country: data['country'],
      newsCases: convertToInt(data['cases']['new']),
      activesCases: data['cases']['active'],
      criticalsCases: data['cases']['critical'],
      totalCases: data['cases']['total'],
      newDeaths: convertToInt(data['deaths']['new']),
      totalDeaths: data['deaths']['total'],
      recovereds: data['recorered'],
      totalTests: data['tests']['total'],
      time: DateTime.parse(data['time']),
    );
  }

  static int convertToInt(String value) {
    if (value == null) return null;
    return int.parse(value);
  }
}
