import 'package:auth_module/screens/home.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTE = TextEditingController();
  final TextEditingController _emailTE = TextEditingController();
  final TextEditingController _nameTE = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Register account",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.purple])),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: kToolbarHeight, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      // logoWidget("assets/images/user_firebase.png", 100, 100),
                      const SizedBox(height: 70.29),
                      textField("User Name", Icons.person, false, _nameTE),
                      const SizedBox(height: 30.29),
                      textField("Email", Icons.alternate_email_outlined, false,
                          _emailTE),
                      const SizedBox(height: 30.29),
                      textField("Password", Icons.lock, true, _passwordTE),
                      const SizedBox(height: 35.29),
                      button(context, false, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      }),
                      const SizedBox(height: 35.29),
                      spannableOption(
                        context: context,
                        isLogin: false,
                        onTap: () {
                          Navigator.of(context).pop(true);
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
