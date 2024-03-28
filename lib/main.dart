import 'package:auth_module/data/user_data.dart';
import 'package:auth_module/screens/home.dart';
import 'package:auth_module/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auth_module/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var isLoggedIn;
  late UserData userData;

  @override
  void initState() {
    checkUserLoginState();
    super.initState();
  }

  checkUserLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = await prefs.getString(Const.TOKEN)?.isNotEmpty ?? false;
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn != null
          ? isLoggedIn
              ? Home()
              : Login()
          : Login(),
    );
  }
}
