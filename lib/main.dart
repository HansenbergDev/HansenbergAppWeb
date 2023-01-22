import 'package:flutter/material.dart';
import 'package:hansenberg_app_core/Utilities/Clients/MenuClient.dart';
import 'package:hansenberg_app_web/Pages/HomePage.dart';
import 'package:hansenberg_app_web/Widgets/MaterialAppWithRoutes.dart';
import 'package:hansenberg_app_core/Utilities/Clients/HttpClient.dart';

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

    String protocol = 'http://';
    String ip = '143.244.196.82';
    String port = '4001';
    String api = '/api/1.0';

    String uri = "$protocol$ip:$port$api";

    HttpClient httpClient = HttpClient(base: uri);
    MenuClient menuClient = MenuClient(httpClient: httpClient);

    return MaterialAppWithRoutes(
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage()
        }
    );
  }
}
