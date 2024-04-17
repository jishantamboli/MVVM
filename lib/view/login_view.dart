import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurepass = ValueNotifier<bool>(true);
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passFocusNode.dispose();
    emailFocusNode.dispose();
    passcontroller.dispose();
    _obsecurepass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authviewmodel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcontroller,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(passFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurepass,
                builder: (context, value, child) {
                  return TextFormField(
                    obscureText: _obsecurepass.value,
                    controller: passcontroller,
                    focusNode: passFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_open),
                      suffixIcon: InkWell(
                          onTap: () {
                            _obsecurepass.value = !_obsecurepass.value;
                          },
                          child: Icon(_obsecurepass.value
                              ? Icons.visibility_off
                              : Icons.visibility_rounded)),
                    ),
                  );
                }),
            SizedBox(
              height: height * 0.08,
            ),
            RoundButton(
              title: 'Login',
              loading: authviewmodel.loading,
              onpress: () {
                if (emailcontroller.text.isEmpty) {
                  Utils.toastMessage('Please enter your email');
                } else if (passcontroller.text.isEmpty) {
                  Utils.toastMessage('Please enter your password');
                } else if (passcontroller.text.length < 6) {
                  Utils.toastMessage('Password enter 6 digit password');
                } else {
                  Map data = {
                    'email': emailcontroller.text.toString(),
                    'password': passcontroller.text.toString()
                  };
                  authviewmodel.loginapi(data, context);
                  print("API hit");
                }
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signup);
                },
                child: Center(child: Text("Don't have an account? Sign Up")))
          ],
        ),
      ),
    );
  }
}
