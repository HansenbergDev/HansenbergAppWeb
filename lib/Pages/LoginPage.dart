import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansenberg_app_core/Utilities/Clients/StaffClient.dart';
import 'package:hansenberg_app_core/Utilities/TokenStorage.dart';
import 'package:hansenberg_app_core/Widgets/IconCupertinoButton.dart';
import 'package:hansenberg_app_core/Widgets/TextFieldWithTitle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.staffClient, required this.tokenStorage}) : super(key: key);

  final StaffClient staffClient;
  final TokenStorage tokenStorage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _sendLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      final token = await widget.staffClient.loginStaff(username, password);


      if (token != null) {
        await widget.tokenStorage.writeToken(token);

        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushReplacementNamed('/staff/weekpage');
        });
      }
    }
    catch(e) {
      //TODO: Notification
    }
  }

  //TODO: Adgangskode synlig

  //TODO: Enter på login siden => login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Personale",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 10,),
              TextfieldWithTitle(
                  title: "Brugernavn",
                  placeholder: "Indtast brugernavn",
                  controller: _usernameController,
                  obscureText: false
              ),
              TextfieldWithTitle(
                  title: "Adgangskode",
                  placeholder: "Adgangskode",
                  controller: _passwordController,
                  obscureText: true
              ),
              IconCupertinoButtonFilled(
                  onPressed: () => _sendLogin(),
                  text: "Login",
                  icon: CupertinoIcons.chevron_right_square)
            ],
          ),
        ),
      ),
    );
  }
}
