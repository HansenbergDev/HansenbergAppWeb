import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialAppWithRoutes extends StatelessWidget {
  const MaterialAppWithRoutes({Key? key, required this.initialRoute, required this.routes, this.title}) : super(key: key);

  final String initialRoute;
  final Map<String, Widget Function(BuildContext)> routes;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: CupertinoColors.systemBackground,
        backgroundColor: CupertinoColors.activeOrange,
        canvasColor: CupertinoColors.activeBlue,
        cardColor: CupertinoColors.systemPurple,
        brightness: Brightness.light
      ),
      title: title == null ? "Hansenberg App Website" : title!,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
