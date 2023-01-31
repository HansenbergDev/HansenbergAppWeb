import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hansenberg_app_core/Utilities/Clients/StaffClient.dart';
import 'package:hansenberg_app_core/Utilities/Clients/TokenClient.dart';
import 'package:hansenberg_app_core/Utilities/TokenStorage.dart';
import 'package:hansenberg_app_core/Widgets/ActivityIndicatorWithTitle.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key, required this.tokenStorage, required this.tokenClient}) : super(key: key);

  final TokenStorage tokenStorage;
  final TokenClient tokenClient;

  Future<bool> _checkToken() async {
    if (await tokenStorage.tokenExists()) {
      String token = await tokenStorage.readToken();
      bool? isTokenValid = await tokenClient.checkTokenValidity(token, isStaffToken: true);

      return isTokenValid ?? false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: FutureBuilder<bool>(
          builder: (BuildContext futureContext, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              bool tokenCheck = snapshot.data!;

              if (tokenCheck) {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushReplacementNamed('/staff/weekpage');
                });
              }
              else {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushReplacementNamed('/staff/login');
                });
              }
            }
            else if (snapshot.hasError) {
              throw Exception("Something happened: ${snapshot.error}");
            }

            return const ActivityIndicatorWithTitle();
          },
          future: _checkToken(),
        )
    );
  }
}
