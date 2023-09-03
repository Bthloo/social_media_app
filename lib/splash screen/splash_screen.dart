import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth_provider.dart';
import '../ui/home/home_screen.dart';
import '../ui/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkLoggedInUser(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? action = prefs.getString('token');
    if (action != null && action != "") {
      // authProvider.currentUser?.accessToken= prefs.getString('token');;
      authProvider.getToken(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);

      return;
    }
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () async {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');
      if (token != null && token != "") {
        authProvider.token = prefs.getString('token');
        authProvider.id = prefs.getInt('id');
        authProvider.getToken(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);

        return;
      }
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xff171717),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(width: 0),
                  borderRadius: BorderRadius.circular(20), //<-- SEE HERE
                ),
                //child: Image.asset('assets/bnoteslogo.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.event_note),
                Text(
                  authProvider.token ?? 'll',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
