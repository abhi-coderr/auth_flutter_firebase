import 'package:flutter/material.dart';

Image logoWidget(String path, double width, double height) {
  return Image.asset(path, fit: BoxFit.fitWidth, width: width, height: height);
}

TextField textField(String title, IconData icon, bool isPassword,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        labelText: title,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

Container button(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(120, 5, 120, 5),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white60;
            } else {
              return Colors.white;
            }
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(isLogin ? "LOG IN" : "SIGN UP",
          style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 12)),
    ),
  );
}

Row spannableOption(
    {required BuildContext context,
    required bool isLogin,
    required void Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have account?", style: TextStyle(color: Colors.white)),
      GestureDetector(
        onTap: () => onTap(),
        child: isLogin
            ? const Text(" SignUp",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            : const Text(" LogIn",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
      )
    ],
  );
}
