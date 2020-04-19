class Statistic {
  final Map<String, int> cases;
  final Map<String, int> deaths;
  final String country;
  final DateTime day;

  Statistic(this.cases, this.deaths, this.country, this.day);
}
