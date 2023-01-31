import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansenberg_app_core/Utilities/Clients/MenuClient.dart';
import 'package:hansenberg_app_core/Utilities/MaterialWeekNavigator.dart';
import 'package:hansenberg_app_core/Utilities/TokenStorage.dart';
import 'package:hansenberg_app_web/Pages/StaffWeekPage.dart';
import 'package:week_of_year/date_week_extensions.dart';

class WeekPageNavigator extends StatelessWidget {
  const WeekPageNavigator({Key? key, required this.menuClient, required this.tokenStorage}) : super(key: key);

  final MenuClient menuClient;
  final TokenStorage tokenStorage;

  String initialRoute() {
    DateTime now = DateTime.now();
    return '${now.weekOfYear}';
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final targetWeek = int.parse(settings.name!);
    final now = DateTime.now();
    final difference = 7 * (targetWeek - now.weekOfYear);
    final next = now.add(Duration(days: difference));
    final mondayOfWeek = next.subtract(Duration(days: next.weekday - 1));

    WidgetBuilder builder;

    builder = (BuildContext context) => StaffWeekPage(
      mondayOfWeek: mondayOfWeek,
      menuClient: menuClient,
      tokenStorage: tokenStorage,
      weekNavigator: MaterialWeekNavigator(context: context, week: mondayOfWeek.weekOfYear),
    );

    return PageRouteBuilder(pageBuilder: (BuildContext context, _, __) => builder(context));
  }

  @override
  Widget build(BuildContext context) {

    return Navigator(
      initialRoute: initialRoute(),
      onGenerateRoute: (RouteSettings settings) => onGenerateRoute(settings),
    );
  }
}
