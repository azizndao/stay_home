import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stayhome/screen/webview_screen.dart';

class AlertTile extends StatelessWidget {
  final String url;
  final String label;

  final String picture;

  const AlertTile({Key key, this.url, this.label, this.picture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.2,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: RawMaterialButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
            ),
            fillColor: Colors.grey.shade200,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(25)),
                  child: SvgPicture.asset(
                    'assets/images/$picture.svg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(label, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
