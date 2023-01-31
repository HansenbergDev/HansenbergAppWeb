import 'package:flutter/material.dart';
import 'package:hansenberg_app_core/Utilities/Clients/MenuClient.dart';
import 'package:hansenberg_app_core/Utilities/Clients/StaffClient.dart';
import 'package:hansenberg_app_core/Utilities/Clients/TokenClient.dart';
import 'package:hansenberg_app_core/Utilities/TokenStorage.dart';
import 'package:hansenberg_app_web/Pages/InitPage.dart';
import 'package:hansenberg_app_web/Pages/LoginPage.dart';
import 'package:hansenberg_app_web/Pages/WeekPage.dart';
import 'package:hansenberg_app_web/Widgets/MaterialAppWithRoutes.dart';
import 'package:hansenberg_app_core/Utilities/Clients/HttpClient.dart';

void main() {
  runApp(const HansenbergAppWebsite());
}


class HansenbergAppWebsite extends StatefulWidget {
  const HansenbergAppWebsite({Key? key}) : super(key: key);

  @override
  State<HansenbergAppWebsite> createState() => _HansenbergAppWebsiteState();
}

class _HansenbergAppWebsiteState extends State<HansenbergAppWebsite> {

  @override
  Widget build(BuildContext context) {

    String ip = '143.244.196.82';
    String port = '4001';
    String urlBase = '$ip:$port';
    String endpointBase = '/api/1.0';


    TokenStorage tokenStorage = TokenStorage();

    HttpClient httpClient = HttpClient(urlBase: urlBase, endpointBase: endpointBase);
    TokenClient tokenClient = TokenClient(httpClient: httpClient);
    StaffClient staffClient = StaffClient(httpClient: httpClient);
    MenuClient menuClient = MenuClient(httpClient: httpClient);

    return MaterialAppWithRoutes(
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) =>
              InitPage(
                tokenStorage: tokenStorage,
                tokenClient: tokenClient,
              ),
          '/staff/login': (BuildContext context) => LoginPage(staffClient: staffClient, tokenStorage: tokenStorage),
          '/staff/weekpage': (BuildContext context) => WeekPage()
        }
    );
  }
}
