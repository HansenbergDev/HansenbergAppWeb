import 'package:flutter/material.dart';
import 'package:hansenberg_website/Pages/HomePage.dart';
import 'package:hansenberg_website/Widgets/MaterialAppWithRoutes.dart';

void main() {
  runApp(const HansenbergWebsite());
}


class HansenbergWebsite extends StatefulWidget {
  const HansenbergWebsite({Key? key}) : super(key: key);

  @override
  State<HansenbergWebsite> createState() => _HansenbergWebsiteState();
}

class _HansenbergWebsiteState extends State<HansenbergWebsite> {

  @override
  Widget build(BuildContext context) {

    return MaterialAppWithRoutes(
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage()
        }
    );
  }
}
