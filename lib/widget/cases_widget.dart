import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CasesWidget extends StatelessWidget {
  const CasesWidget({Key key, this.color, this.name, this.value, this.picture})
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
