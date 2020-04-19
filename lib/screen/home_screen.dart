import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stayhome/app.dart';
import 'package:stayhome/util/clippsers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> get currentCountry => App.of(context).currentCountry;

  set currentCountry(Map<String, dynamic> value) {
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
            var newStats = await App.of(context).provider.statistics;
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
                        Text(currentCountry['country']),
                        Image.asset(
                          'assets/images/affected_location.png',
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _CountryStats(stats: currentCountry),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  'Les symptômes les plus communs sont: ‎',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              for (var item in App.of(context).symptoms) _AlertTile(item),
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
      title: Text(stats['country']),
      onTap: () {
        setState(() => currentCountry = stats);
        Navigator.pop(context);
      },
    );
  }
}

class _CountryStats extends StatelessWidget {
  const _CountryStats({Key key, @required this.stats}) : super(key: key);

  final Map<String, dynamic> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _CasesWidget(
            picture: 'case',
            color: Theme.of(context).primaryColorDark.withRed(100),
            name: 'Confirmés',
            value: stats['cases']['total'],
          ),
          _CasesWidget(
            picture: 'recovered',
            color: Theme.of(context).primaryColorDark.withBlue(200),
            name: 'guéries',
            value: stats['cases']['recovered'],
          ),
          _CasesWidget(
            picture: 'death',
            color: Theme.of(context).primaryColorDark.withRed(200),
            name: 'Décès',
            value: stats['deaths']['total'],
          ),
        ],
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  final Map<String, String> alert;

  const _AlertTile(this.alert, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(25)),
              child: SizedBox.expand(
                child: Image.asset(
                  'assets/images/${alert['picture']}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: <Widget>[],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CasesWidget extends StatelessWidget {
  const _CasesWidget({Key key, this.color, this.name, this.value, this.picture})
      : super(key: key);

  final Color color;
  final String name;
  final value;
  final String picture;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: SvgPicture.asset(
                'assets/images/$picture.svg',
                allowDrawingOutsideViewBox: false,
                placeholderBuilder: (context) {
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(name),
                  ),
                  Container(
                    child: Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
