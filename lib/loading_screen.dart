import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey.shade50,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
