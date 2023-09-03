import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socila_app/custom_widget/bottom_sheet.dart';
import 'package:socila_app/providers/auth_provider.dart';
import 'package:socila_app/splash%20screen/splash_screen.dart';
import 'package:socila_app/ui/home/home_screen.dart';
import 'package:socila_app/ui/login_screen/login_screen.dart';
import 'package:socila_app/ui/register_screen/register_screen.dart';

import 'custom_widget/create_post.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  late AuthProvider authProvider;

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //authProvider = Provider.of<AuthProvider>(context,listen: false);
    // authProvider.getToken(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreatePost.routeName: (context) => CreatePost(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        AllCommentsWidget.routeName: (context) => AllCommentsWidget(),
      },
    );
  }
}
