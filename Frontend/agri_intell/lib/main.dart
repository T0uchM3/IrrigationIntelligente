import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irregation/Screens/pages.dart';
import 'package:irregation/constants.dart';
import 'package:irregation/middleware/AuthMiddleware.dart';
import 'package:irregation/notification/NotificationApi.dart';
import 'package:irregation/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

import 'Screens/Login/Signin_screen.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationApi.init();
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      initialRoute: "/splash",
      // home: SplashScreen(),
      getPages: [
        GetPage(
          name: "/",
          page: () => SigninScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: "/splash",
          page: () => SplashScreen(),
          middlewares: [],
        ),
        GetPage(
          name: "/home",
          page: () => Pages(),
          middlewares: [],
        ),
      ],
      //const SigninScreen(),
    );
  }
}
