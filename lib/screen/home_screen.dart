import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stayhome/app.dart';
import 'package:stayhome/util/clippsers.dart';
import 'package:stayhome/util/models.dart';
import 'package:stayhome/widget/alert_tile.dart';
import 'package:stayhome/widget/country_stats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Statistic get currentCountry => App.of(context).currentCountry;

  set currentCountry(Statistic value) {
    App.of(context).currentCountry = value;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            var newStats = await App.of(context).provider.lastStatistics;
            App.of(context).refreshStats(newStats);
            setState(() {});
          },
          child: ListView(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/doctor.png'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: RawMaterialButton(
                  shape: StadiumBorder(),
                  fillColor: Colors.grey.shade200,
                  elevation: 0,
                  onPressed: () => _showCountries(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(currentCountry.country),
                        Image.asset(
                          'assets/images/affected_location.png',
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              CountryStats(stats: currentCountry),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  'Les symptômes les plus communs sont: ‎',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              for (var item in App.of(context).symptoms) AlertTile(item),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountries(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: _buildCountries,
                  itemCount: App.of(context).statistics.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountries(context, index) {
    var stats = App.of(context).statistics[index];
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.flag)),
      title: Text(stats.country),
      onTap: () {
        setState(() => currentCountry = stats);
        Navigator.pop(context);
      },
    );
  }
}
