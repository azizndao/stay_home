import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stayhome/util/models.dart';

class DataProvider {
  Future<List> fetchData(String url) async {
    final resp = await http.get(
      'https://covid-193.p.rapidapi.com/$url',
      headers: {
        "x-rapidapi-host": "covid-193.p.rapidapi.com",
        "x-rapidapi-key": "506cb5d334msh345309840af411dp13fb48jsnde1587534d09",
      },
    );

    return (json.decode(resp.body) as Map<String, dynamic>)['response'] as List;
  }

  Future<List<String>> get affectedCountries async {
    final resp = await fetchData('countries');
    final countries = resp.map((item) => item as String).toList();
    return countries;
  }

  Future<List> countryStats(String country) async {
    final day = DateTime.now().toString().substring(0, 10);
    return await fetchData('history?country=$country&day=$day');
  }

  Future<List> get statistics async => await fetchData('statistics');
}
