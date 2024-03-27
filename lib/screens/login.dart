import 'package:auth_module/screens/home.dart';
import 'package:auth_module/screens/signup.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordTE = TextEditingController();
  final TextEditingController _emailTE = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.blueAccent])),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 180, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      logoWidget("assets/images/user_firebase.png", 100, 100),
                      const SizedBox(height: 70.29),
                      textField("Email", Icons.alternate_email_outlined, false,
                          _emailTE),
                      const SizedBox(height: 30.29),
                      textField("Password", Icons.lock, true, _passwordTE),
                      const SizedBox(height: 35.29),
                      button(context, true, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      }),
                      const SizedBox(height: 35.29),
                      spannableOption(
                        context: context,
                        isLogin: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
