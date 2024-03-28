import 'package:auth_module/screens/login.dart';
import 'package:auth_module/utils/app_preferencies.dart';
import 'package:auth_module/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name = '';
  var email = '';

  void initializeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.getString(Const.USER_NAME) ?? "";
    email = await prefs.getString(Const.USER_EMAIL) ?? "";
    setState(() { });
  }

  @override
  void initState() {
    setState(() {
      initializeUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                signOutFromGoogle();
                Shared.writeString(Const.TOKEN, "");
                Shared.writeString(Const.USER_NAME, "");
                Shared.writeString(Const.USER_EMAIL, "");
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purpleAccent, Colors.blueAccent])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Email : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  Text("Name : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15))
                ]),
                SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(email.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                  Text(name.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15))
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
