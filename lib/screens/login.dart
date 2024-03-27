import 'package:auth_module/data/user_data.dart';
import 'package:auth_module/screens/home.dart';
import 'package:auth_module/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../utils/helper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;
  late UserData userData;

  ValueNotifier userCredential = ValueNotifier('');

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
                        if (_passwordTE.text.isNotEmpty &&
                            _emailTE.text.isNotEmpty) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTE.text,
                                  password: _passwordTE.text)
                              .then((value) => {navigationToHome()})
                              .onError((error, stackTrace) =>
                                  {showToast(error.toString())});
                        } else {
                          showToast("Fill all field");
                        }
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
                      ),
                      const SizedBox(height: 35.29),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (!isLoggedIn) {
                                userCredential.value = await signInWithGoogle();
                                if (userCredential.value != null) {
                                  isLoggedIn = true;

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(
                                                  data: UserData(
                                                userCredential
                                                    .value.user!.displayName
                                                    .toString(),
                                                userCredential.value.user!.email
                                                    .toString(),
                                              ))));

                                  final snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Awesome, Login!',
                                        message: 'Explore the new world..',
                                        contentType: ContentType.success,
                                        inMaterialBanner: true,
                                      ));
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                  // showToast(userCredential.value.user!.email
                                  //     .toString());
                                } else {
                                  showToast("Try again");
                                }
                              }

                              // _googleSignIn.signIn().then((userData) {
                              //   setState(() {
                              //     isLoggedIn = true;
                              //     _userObj = userData!;
                              //   });
                              // }).catchError((e) {
                              //   print(e);
                              // });
                            }, // Image tapped
                            child: Image.asset(
                              "assets/images/google_img.png",
                              fit: BoxFit.fitWidth, // Fixes border issues
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          logoWidget("assets/images/facebook.png", 50, 50),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  void navigationToHome() {}
}
